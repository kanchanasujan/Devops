module "db" {
  for_each = var.db
  source = "./module"
  component_name = each.key
  rgname = var.rgname
  image_id = var.image_id
}


module "apps" {

  depends_on = [module.db]

  for_each = var.apps
  source = "./module"
  component_name = each.key
  rgname = var.rgname
  image_id = var.image_id
}



module "ui" {

  depends_on = [module.apps]

  for_each = var.ui
  source = "./module"
  component_name = each.key
  rgname = var.rgname
  image_id = var.image_id
}
