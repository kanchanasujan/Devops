module "sample" {
  source = "./sample"
  test = "TESTING"
}

module "sample1" {
  source = "./sample"
  test = module.sample.demo1
}

output "demo1" {
  value = module.sample.demo1
}
