rockspec_format = '3.0'
package = 'nlua'
version = 'scm-1'

source = {
  url = 'git+https://github.com/mfussenegger/nlua'
}

deploy = {
    wrap_bin_scripts = false,
}

test_dependencies = {
    "nlua"
}

build = {
   type = "builtin",
   modules = {},
   install = {
     bin = { nlua = 'nlua', },
   },
}
