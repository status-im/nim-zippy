import os, tables, zippy/tarballs

block: # .tar
  let tarball = Tarball()
  tarball.open("tests/data/tarballs/basic.tar")

  for path, entry in tarball.contents:
    doAssert readFile("tests/data/" & path) == entry.contents

block: # .tar.gz
  let tarball = Tarball()
  tarball.open("tests/data/tarballs/basic.tar.gz")

  for path, entry in tarball.contents:
    doAssert readFile("tests/data/" & path) == entry.contents

block: # .tar
  let tarball = Tarball()
  tarball.open("tests/data/tarballs/dir.tar")

  for path, entry in tarball.contents:
    if entry.kind == ekNormalFile:
      doAssert readFile("tests/data/" & splitPath(path).tail) == entry.contents

block: # .tar.gz
  let tarball = Tarball()
  tarball.open("tests/data/tarballs/dir.tar.gz")

  for path, entry in tarball.contents:
    if entry.kind == ekNormalFile:
      doAssert readFile("tests/data/" & splitPath(path).tail) == entry.contents

# block:
#   removeFile("examples.tar.gz")
#   removeFile("tmp_tarball1.tar.gz")
#   removeDir("tmp_tarball1/")
#   removeDir("tmp_tarball2/")
#   createTarball("examples/", "examples.tar.gz")
#   extractAll("examples.tar.gz", "tmp_tarball1/")

#   for (kind, path) in walkDir("tmp_tarball1"):
#     doAssert kind == pcFile
#     doAssert readFile("examples/" & splitPath(path).tail) == readFile(path)

#   createTarball("tmp_tarball1/", "tmp_tarball1.tar.gz")
#   extractAll("tmp_tarball1.tar.gz", "tmp_tarball2/")

#   for (kind, path) in walkDir("tmp_tarball2"):
#     doAssert kind == pcFile
#     doAssert readFile("tmp_tarball1/" & splitPath(path).tail) == readFile(path)

# block:
#   let tarball = Tarball()
#   tarball.open("tests/data/tarballs/Nim-1.4.2.tar.gz")

#   var i: int
#   for path, entry in tarball.contents:
#     inc i
#   doAssert i == 3026

#   removeDir("tmp/tarballs")
#   createDir("tmp")
#   tarball.extractAll("tmp/tarballs")

#   for path, entry in tarball.contents:
#     if entry.kind == ekDirectory:
#       doAssert dirExists("tmp/tarballs" / path)
#     else:
#       doAssert fileExists("tmp/tarballs" / path)
