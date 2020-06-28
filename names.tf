# This locals implement the resource correct names based on GC CAF naming convention rules

locals {
  postfix = "-rg"
  maxLenght = var.maxLength > 90 ? 90 : var.maxLength # Make sure provided maxLenght does not exceed resource max lenght
  env_4      = substr(var.env, 0, 4) # Make sure env lenght does not exceed 4
  regex = "/[^0-9A-Za-z-_.]/" # Anti-pattern to match all characters not in: 0-9, a-z, A-Z, -, _, .
  
  userDefinedString_replaced = [
    for item in var.resource_groups: 
    replace(item.userDefinedString, "-", "_")
  ]
  
  names = [
    for userDefinedString_replaced in local.userDefinedString_replaced:
    substr(replace("${local.env_4}-${userDefinedString_replaced}${local.postfix}", local.regex, ""), 0, local.maxLenght)
  ]
}