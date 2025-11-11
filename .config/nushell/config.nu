# ~/.config/nushell/env.nu

let fish_completer = {|spans|
    fish --command $"complete '--do-complete=($spans | str replace --all "'" "\\'" | str join ' ')'"
    | from tsv --flexible --noheaders --no-infer
    | rename value description
    | update value {|row|
        let value = $row.value
        let need_quote = ['\' ',' '[' ']' '(' ')' ' ' '\t' "'" '"' "`"] | any {$in in $value}
        if ($need_quote and ($value | path exists)) {
            let expanded_path = if ($value starts-with ~) {$value | path expand --no-symlink} else {$value}
            $'"($expanded_path | str replace --all "\"" "\\\"")"'
        } else {$value}
    }
}

# This completer will use carapace by default
let external_completer = {|spans|
    let expanded_alias = scope aliases
    | where name == $spans.0
    | get -o 0.expansion

    let spans = if $expanded_alias != null {
        $spans
        | skip 1
        | prepend ($expanded_alias | split row ' ' | take 1)
    } else {
        $spans
    }

    match $spans.0 {
        _ => $fish_completer
    } | do $in $spans
}

$env.LS_COLORS = (vivid generate gruvbox-dark)
$env.config.edit_mode = 'vi'
$env.config = {
    buffer_editor: "nvim",
    show_banner: false,
    table: {
        header_on_separator: true,
        mode: 'single'
        show_empty: true
    }
    filesize: {
        unit: 'metric'
    },
    completions: {
        external: {
            enable: true
            completer: $external_completer
        }
    }
}

load-env {
    EDITOR: "nvim"
    VISUAL: "nvim"
    XDG_DATA_HOME: $"($env.HOME)/.local/share"
    XDG_CONFIG_HOME: $"($env.HOME)/.config"
    XDG_STATE_HOME: $"($env.HOME)/.local/state"
    XDG_CACHE_HOME: $"($env.HOME)/.cache"
}

[
    $env.XDG_DATA_HOME
    $env.XDG_CONFIG_HOME
    $env.XDG_STATE_HOME
    $env.XDG_CACHE_HOME
    $"($env.XDG_DATA_HOME)/applications"
] | each {|dir| mkdir $dir}

load-env {
    GOPATH: $"($env.XDG_DATA_HOME)/go"
    CUDA_CACHE_PATH: $"($env.XDG_CACHE_HOME)/nv"
    PYTHON_HISTORY: $"($env.XDG_STATE_HOME)/python_history"
    PYTHONPYCACHEPREFIX: $"($env.XDG_CACHE_HOME)/python"
    PYTHONUSERBASE: $"($env.XDG_DATA_HOME)/python"
    PSQL_HISTORY: $"($env.XDG_STATE_HOME)/psql_history"
    SQLITE_HISTORY: $"($env.XDG_STATE_HOME)/sqlite_history"
    NPM_CONFIG_USERCONFIG: $"($env.XDG_CONFIG_HOME)/npm/npmrc"
    CARGO_HOME: $"($env.XDG_DATA_HOME)/cargo"
    RUSTUP_HOME: $"($env.XDG_DATA_HOME)/rustup"
    #JULIA_DEPOT_PATH: $"($env.XDG_DATA_HOME)/julia:($env.JULIA_DEPOT_PATH | default '')"
    #JULIAUP_DEPOT_PATH: $"($env.XDG_DATA_HOME)/julia"
    NODE_REPL_HISTORY: $"($env.XDG_STATE_HOME)/node_repl_history"
    DOCKER_CONFIG: $"($env.XDG_CONFIG_HOME)/docker"
    GHCUP_USE_XDG_DIRS: "true"
    OPAMROOT: $"($env.XDG_DATA_HOME)/opam"
    _JAVA_OPTIONS: $"-Djava.util.prefs.userRoot=($env.XDG_CONFIG_HOME)/java"
    OMNISHARPHOME: $"($env.XDG_CONFIG_HOME)/omnisharp"
    NUGET_PACKAGES: $"($env.XDG_CACHE_HOME)/NuGetPackages"
    HISTFILE: $"($env.XDG_STATE_HOME)/bash/history"
}

let new_paths = [
    $"($env.HOME)/.local/bin"
    $"($env.CARGO_HOME)/bin"
    $"($env.GOPATH)/bin"
]

load-env {
    PATH: ($env.PATH | split row (char esep) | append $new_paths | uniq)
}
