-- CoC configuration
vim.g.coc_global_extensions = {
    'coc-json',
    'coc-pyright',
    'coc-highlight',
    'coc-snippets'
}

-- Airline integration
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#buffer_nr_show'] = 1
vim.g['airline#extensions#coc#enabled'] = 1

-- Diagnostic configuration
vim.g.coc_preferences = {
    diagnostic = {
        virtualText = false,
        virtualTextCurrentLineOnly = true,
        checkCurrentLine = true
    },
    colors = {
        enable = true
    },
    highlight = {
        trace = 'verbose'
    }
}

-- Python specific settings
vim.g.coc_pyright_config = {
    python = {
        analysis = {
            autoImportCompletions = true,
            typeCheckingMode = 'basic',
            stubPath = '~/devel/adtrac/typings'
        },
        linting = {
            enabled = true,
            ruffEnabled = true
        }
    }
}
