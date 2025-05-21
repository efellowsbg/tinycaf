output "linux_function_apps" {
  value = length(module.linux_function_apps) > 0 ? {
    for key, fa in module.linux_function_apps :
    key => fa
    if length(fa) > 0
  } : {}
}

# output "windows_function_apps" {
#   value = length(module.windows_function_apps) > 0 ? {
#     for key, fa in module.windows_function_apps :
#     key => fa
#     if length(fa) > 0
#   } : {}
# }
