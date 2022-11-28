local util = require "lspconfig.util"
return {
  setup = {
    cmd = { "java", "-jar", "$HOME/.local/share/nvim/site/pack/packer/start/groovy-language-server/build/libs/groovy-language-server-all.jar" },
    root_dir = util.root_pattern {'gradlew'},
  }
}
