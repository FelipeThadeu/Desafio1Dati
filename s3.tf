resource "aws_s3_bucket" "dati-felipethadeulpsantos-desafio1" {
  bucket = "dati-felipethadeulpsantos-desafio1"
  acl    = "public-read"
  
  website {
    index_document = "index.html"
  }
}