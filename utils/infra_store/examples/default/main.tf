module "infra_store" {
  source = "../.."
}

output "const" {
  value = module.infra_store.const
}
