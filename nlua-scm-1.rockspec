rockspec_format = '3.0'
package = 'nlua'
version = 'scm-1'

source = {
  url = 'git+https://github.com/mfussenegger/nlua'
}

deploy = {
    wrap_bin_scripts = false,
}

dependencies = {
    "lua == 5.1",
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
   platforms = {
     win32 = {
       install = {
         bin = { 
          nlua = 'nlua', 
          ['nlua.bat'] = 'nlua.bat',
         },
       },
     }
   },
}
