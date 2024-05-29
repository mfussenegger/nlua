rockspec_format = '3.0'
package = "example_project"
version = "dev-1"
source = {
   url = "git+https://github.com/mfussenegger/nlua"
}
test_dependencies = {
    "nlua"
}
build = {
   type = "builtin",
}
