# Spec for the diraction command

# PB: rely on funcion, only existing in zsh, but zsh has end...
# §todo: steps definitions.

setopt aliases
CURRENT_DIR="$PWD"

describe "Diraction Commands"

  source ./diractions.plugin.zsh

  describe "Dispatcher"

    it "Transfer existing commands"
        ok=false
        stub_command diraction-list "ok=true"
        diraction list
        unstub_command diraction-list
        assert equal $ok true

     end
     it "Error for non existing commands"
        diraction whatthefuck 2> /dev/null
        assert equal $? 1
      end
     it "Error if no subcommand"
        diraction 2> /dev/null
        assert equal $? 1
     end
  end

  describe "Diraction Creation"
    it "create working diraction"
     dir='/tmp/some-name'
        mkdir -p "$dir"
        diraction create testitest "$dir"
        assert match "$(type testitest)" "*alias*"
        testitest
        assert equal $PWD "$dir"
        diraction destroy testitest
      end
      it "create working diraction with name in it"
        dir='/tmp/some name with space'
        mkdir -p "$dir"
        diraction create testitest "$dir"
        assert match "$(type testitest)" "*alias*"
        testitest
        assert equal $PWD "$dir"
        diraction destroy testitest
      end

    it "Deny creation if non existing"
    end

    it "Allow creation if non existing but force"
    end
  end
end

cd "$CURRENT_DIR"
