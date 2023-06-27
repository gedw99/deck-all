/// scans a folder and then converts packs into zips.
/// For example, we have to deal with:
/// *.app --> *.app.zip
/// *.web --> *.app.zip

package main

import (
	"archive/zip"
	"flag"
	"fmt"
	"io"
	"log"
	"os"
	"path/filepath"
	"strings"
)

var (
	inPath = "nil"

	outPath = "nil"
)

func main() {

	// PATH to parse
	inPathFlag := flag.String("in", "", "File path to look for binaries.")
	outPathFlag := flag.String("out", "", "File path to output zips to.")
	flag.Parse()

	p := *inPathFlag
	outPath = *outPathFlag

	if outPath == "" {
		/*
			fmt.Println("")
			fmt.Println("-- OUTPATH_FLAG--")
			fmt.Println(o)
		*/
		fmt.Println("outPath is required")
		return

	}

	if *inPathFlag != "" {
		/*
			fmt.Println("")
			fmt.Println("-- PATH_FLAG--")
			fmt.Println(p)
		*/
		inPath = p
	} else {
		// CWD to parse
		pathCwd, err := os.Getwd()
		if err != nil {
			log.Println(err)
		}
		/*
			fmt.Println("")
			fmt.Println("-- PATH_CWD--")
			fmt.Println(pathCwd)
		*/
		inPath = pathCwd
	}

	fmt.Println("")
	fmt.Println("-- PATH--")
	fmt.Println(inPath)

	// in
	// /Users/apple/workspace/go/src/github.com/gedw99/deck-all/.bin

	// out
	// /Users/apple/workspace/go/src/github.com/gedw99/deck-all/.release

	scan1(inPath)

}

func scan1(path string) {
	// for inside .bin folder
	fmt.Println("")
	fmt.Println("-- scan1")

	files, err := os.ReadDir(path)
	if err != nil {
		log.Fatal(err)
	}

	for _, file := range files {
		fmt.Println(file.Name(), file.IsDir())

		// if dir, then do it again
		if file.IsDir() {
			path := filepath.Join(path, file.Name())
			fmt.Println("Path => ", path)
			fmt.Println("Folder => ", file.Name())

			scan2(path, file.Name())
		}
	}
}

func scan2(path string, folderName string) {
	// for inside OS_ARCH folder
	fmt.Println("")
	fmt.Println("-- scan2")
	fmt.Println("path => ", path)
	fmt.Println("folderName => ", folderName)

	files, err := os.ReadDir(path)
	if err != nil {
		log.Fatal(err)
	}

	//dstPrefix := "os_arch"
	dstPrefix := folderName

	for _, file := range files {
		fmt.Println("")
		fmt.Println(file.Name())
		fmt.Println("IsDir => ", file.IsDir())

		if file.IsDir() {
			// zip in place, then copy it to out with prefix.

			srcPath := filepath.Join(path, file.Name())
			fmt.Println("srcPath => ", srcPath)

			dstPath := filepath.Join(path, file.Name()+".zip")
			fmt.Println("dstPath => ", dstPath)

			FolderZip(srcPath, dstPath)

			// then copy it to put...
			newDstPath := filepath.Join(outPath, dstPrefix+"_"+file.Name()+".zip")

			err := FileCopy(dstPath, newDstPath)
			if err != nil {
				fmt.Println("Path => ", err)
				return
			}

		} else {
			// copy it to out with prefix.
			srcPath := filepath.Join(path, file.Name())

			dstPath := filepath.Join(outPath, dstPrefix+"_"+file.Name())

			err := FileCopy(srcPath, dstPath)
			if err != nil {
				fmt.Println("Path => ", err)
				return
			}
		}

	}
}

// File copies a single file from src to dst
func FileCopy(src, dst string) error {

	fmt.Println("-- FileCopy")
	fmt.Println("src => ", src)
	fmt.Println("dst => ", dst)

	var err error
	var srcfd *os.File
	var dstfd *os.File
	var srcinfo os.FileInfo

	if srcfd, err = os.Open(src); err != nil {
		return err
	}
	defer srcfd.Close()

	if dstfd, err = os.Create(dst); err != nil {
		return err
	}
	defer dstfd.Close()

	if _, err = io.Copy(dstfd, srcfd); err != nil {
		return err
	}
	if srcinfo, err = os.Stat(src); err != nil {
		return err
	}
	return os.Chmod(dst, srcinfo.Mode())
}

func FolderZip(pathToZip, destinationPath string) error {
	fmt.Println("-- FolderZip")
	fmt.Println("pathToZip =>       ", pathToZip)
	fmt.Println("destinationPath => ", destinationPath)

	destinationFile, err := os.Create(destinationPath)
	if err != nil {
		return err
	}
	myZip := zip.NewWriter(destinationFile)
	err = filepath.Walk(pathToZip, func(filePath string, info os.FileInfo, err error) error {
		if info.IsDir() {
			return nil
		}
		if err != nil {
			return err
		}
		relPath := strings.TrimPrefix(filePath, filepath.Dir(pathToZip))
		zipFile, err := myZip.Create(relPath)
		if err != nil {
			return err
		}
		fsFile, err := os.Open(filePath)
		if err != nil {
			return err
		}
		_, err = io.Copy(zipFile, fsFile)
		if err != nil {
			return err
		}
		return nil
	})
	if err != nil {
		return err
	}
	err = myZip.Close()
	if err != nil {
		return err
	}
	return nil
}
