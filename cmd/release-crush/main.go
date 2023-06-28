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

	"os"
	"path/filepath"
	"strings"

	log "github.com/sirupsen/logrus"
)

var (
	inPath = "nil"

	outPath = "nil"
)

func init() {
	// LOGGING
	environment := os.Getenv("ENV")

	if environment == "production" {
		// for json so we can do log aggrgation
		log.SetFormatter(&log.JSONFormatter{})
	} else {
		// The TextFormatter is default, you don't actually have to do this.
		log.SetFormatter(&log.TextFormatter{})
	}

	//log.SetReportCaller(true)

	// Only log the warning severity or above.
	//log.SetLevel(log.WarnLevel)
	//log.SetLevel(log.InfoLevel)
	log.SetLevel(log.DebugLevel)
}

func main() {

	// FLAGS
	inPathFlag := flag.String("in", "", "File path to look for binaries.")
	outPathFlag := flag.String("out", "", "File path to output zips to.")

	flag.Parse()

	p := *inPathFlag
	outPath = *outPathFlag

	// out is mandatory
	if outPath == "" {

		log.Info("OUTPATH_FLAG => ", outPath)

		fmt.Println("outPath is required")
		return
	}

	// in is optional, and we use the current dir if not supplied.
	if *inPathFlag != "" {

		log.Info("INPATH_FLAG => ", p)

		inPath = p
	} else {
		// CWD to parse
		pathCwd, err := os.Getwd()
		if err != nil {
			log.Println(err)
		}

		log.Info("INPATH_CWD => ", pathCwd)

		inPath = pathCwd
	}

	log.Debug("INPATH => ", inPath)

	scan1(inPath)

}

func scan1(path string) {
	// for inside .bin folder

	log.Info("-- scan1")

	files, err := os.ReadDir(path)
	if err != nil {
		log.Fatal(err)
	}

	for _, file := range files {
		fmt.Println(file.Name(), file.IsDir())

		log.Info("visiting File Name => ", file.Name())
		log.Info("visiting File ISDir => ", file.IsDir())

		// if dir, then do it again
		if file.IsDir() {
			path := filepath.Join(path, file.Name())
			log.Info("Path => ", path)
			log.Info("Folder => ", file.Name())

			scan2(path, file.Name())
		}
	}
}

func scan2(path string, folderName string) {
	// for inside OS_ARCH folder
	fmt.Println("")

	log.Info("-- scan2")
	log.Info("path => ", path)
	log.Info("folderName => ", folderName)

	files, err := os.ReadDir(path)
	if err != nil {
		log.Fatal(err)
	}

	//dstPrefix := "os_arch"
	dstPrefix := folderName

	for _, file := range files {
		fmt.Println("")

		log.Info("visiting File Name => ", file.Name())
		log.Info("visiting File ISDir => ", file.IsDir())

		if file.IsDir() {
			// zip in place, then copy it to out with prefix.

			srcPath := filepath.Join(path, file.Name())
			log.Info("srcPath => ", srcPath)

			dstPath := filepath.Join(path, file.Name()+".zip")
			log.Info("dstPath => ", dstPath)

			FolderZip(srcPath, dstPath)

			// then copy it to put...
			newDstPath := filepath.Join(outPath, dstPrefix+"_"+file.Name()+".zip")

			err := FileCopy(dstPath, newDstPath)
			if err != nil {
				log.Info("Path => ", err)
				return
			}

		} else {
			// copy it to out with prefix.
			srcPath := filepath.Join(path, file.Name())

			dstPath := filepath.Join(outPath, dstPrefix+"_"+file.Name())

			err := FileCopy(srcPath, dstPath)
			if err != nil {
				log.Info("Path => ", err)
				return
			}
		}

	}
}

// File copies a single file from src to dst
func FileCopy(src, dst string) error {

	log.Info("-- FileCopy")
	log.Info("src => ", src)
	log.Info("dst => ", dst)

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
	log.Info("-- FolderZip")
	log.Info("pathToZip =>       ", pathToZip)
	log.Info("destinationPath => ", destinationPath)

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
