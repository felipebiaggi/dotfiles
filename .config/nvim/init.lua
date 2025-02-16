local opts_keymap = { noremap = true, silent = true }

-- Definir <space> como tecla 'leader'
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Indica se o sistema possui uma fonte Nerd Font instalada
vim.g.have_nerd_font = true

-- Exibir números de linha por padrão
vim.opt.number = true

-- Habilitar o uso do mouse
vim.opt.mouse = 'a'

-- Integrar copiar (y) e colar (p) com a área de transferência do sistema operacional
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Habilitar indentação mantida ao quebrar linhas
vim.opt.breakindent = true
vim.opt.showbreak = '↳ '

-- Tornar a busca **case-insensitive** (ignora maiúsculas/minúsculas)
vim.opt.ignorecase = true
vim.opt.smartcase = true -- Se a busca contiver letras maiúsculas, diferencia maiúsculas de minúsculas

-- Manter a coluna de sinais (signcolumn) sempre visível
vim.opt.signcolumn = 'yes'

-- Reduzir o tempo de atualização do cursor
vim.opt.updatetime = 250

-- Diminuir o tempo de espera para combinações de teclas mapeadas
vim.opt.timeoutlen = 300

-- Definir como novas divisões de tela devem ser abertas
vim.opt.splitright = true -- Abre novas janelas verticais à direita
vim.opt.splitbelow = true -- Abre novas janelas horizontais abaixo

-- Configurar como o Neovim exibirá caracteres invisíveis no editor.
-- Veja `:help 'list'`
-- e `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Visualizar substituições ao vivo, enquanto digita!
vim.opt.inccommand = 'split'

-- Destacar a linha atual do cursor
vim.opt.cursorline = true

-- Manter um número mínimo de linhas acima e abaixo do cursor visíveis
vim.opt.scrolloff = 10

-- Exibe Tab como 2 espaços
-- vim.opt.tabstop = 2

-- Indentação automática usa 2 espaços
-- vim.opt.shiftwidth = 2

-- Atalho para limpar a busca ao pressionar <Esc>
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Atalho para sair do modo terminal pressionando <Esc><Esc>
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal' })

-- Atalho para comentarios
vim.keymap.set('n', '<leader><Tab>', 'gcc', { desc = 'Toggle omments', remap = true })
vim.keymap.set('v', '<leader><Tab>', 'gc', { desc = 'Toggle omments', remap = true })

-- Atalho para salvar
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { desc = 'Save file' })

-- Atalho para sair
vim.keymap.set('n', '<C-q>', '<cmd>q<CR>', { desc = 'Quit file' })

-- Atalho para fechar buffer
vim.keymap.set('n', '<leader>x', '<cmd>bd<CR>', { desc = 'Close buffer' })

-- Atalho para criar buffer
vim.keymap.set('n', '<leader>b', '<cmd>enew<CR>', { desc = 'Create buffer' })

-- Salta entre buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { desc = 'Previous Buffer' })

-- Atalho para primeira palavra da linha
vim.keymap.set('n', '<Home>', '^', { desc = 'go to fist word' })

-- Muda behavior do x no modo normal
vim.keymap.set('n', 'x', '"_x', opts_keymap)

-- Scroll vertical centralizado
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts_keymap)
vim.keymap.set('n', 'C-u>', '<C-d>zz', opts_keymap)

vim.keymap.set('n', 'n', 'nzzzv', opts_keymap)
vim.keymap.set('n', 'N', 'Nzzzv', opts_keymap)

-- Identação
vim.keymap.set('v', '<', '<gv', { desc = 'Return indent' })
vim.keymap.set('v', '>', '>gv', { desc = 'Advance indent' })

-- Navegar
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts_keymap)
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts_keymap)
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts_keymap)
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts_keymap)

-- Resize
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts_keymap)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts_keymap)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts_keymap)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts_keymap)

-- Destacar o texto ao copiar (yank)
-- Teste com `yap` no modo normal
-- Veja `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Destacar texto ao copiar',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank {
      higroup = 'IncSearch', -- Usa a cor do IncSearch para destacar
      timeout = 200, -- Destaca por 200ms
    }
  end,
})

-- [[ Instalar automaticamente o gerenciador de plugins `lazy.nvim` ]]
-- Veja `:help lazy.nvim.txt` ou https://github.com/folke/lazy.nvim para mais informações
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Erro ao clonar lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    -- Detecta automaticamente os valores de tabstop e shiftwidth com base no arquivo aberto
    -- Isso permite que o Neovim ajuste a indentação automaticamente conforme o arquivo
    'tpope/vim-sleuth',
  },
  {
    -- Adiciona sinais do Git na lateral do editor (gutter)
    -- Exibe ícones indicando quais linhas foram adicionadas, modificadas ou deletadas
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' }, -- Linha adicionada
        change = { text = '~' }, -- Linha modificada
        delete = { text = '_' }, -- Linha deletada
        topdelete = { text = '‾' }, -- Linha deletada no topo do arquivo
        changedelete = { text = '~' }, -- Linha modificada e deletada
      },
    },
  },
  {
    -- Plugin útil para exibir atalhos disponíveis enquanto você digita
    'folke/which-key.nvim',
    -- Carrega o plugin quando o Neovim inicia
    event = 'VimEnter',

    opts = {
      -- Tempo (em milissegundos) entre pressionar uma tecla e abrir o which-key
      -- Essa configuração é independente de vim.opt.timeoutlen
      delay = 0,

      icons = {
        -- Define se os ícones devem ser exibidos com base no suporte a Nerd Font
        mappings = vim.g.have_nerd_font,

        -- Se estiver usando Nerd Font, usa os ícones padrões do which-key.
        -- Caso contrário, define um conjunto manual de ícones para representar as teclas.
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ', -- Seta para cima
          Down = '<Down> ', -- Seta para baixo
          Left = '<Left> ', -- Seta para esquerda
          Right = '<Right> ', -- Seta para direita
          C = '<C-…> ', -- Tecla Ctrl
          M = '<M-…> ', -- Tecla Alt (Meta)
          D = '<D-…> ', -- Tecla Command (Mac)
          S = '<S-…> ', -- Tecla Shift
          CR = '<CR> ', -- Tecla Enter (Carriage Return)
          Esc = '<Esc> ', -- Tecla Escape
          ScrollWheelDown = '<ScrollWheelDown> ', -- Roda do mouse para baixo
          ScrollWheelUp = '<ScrollWheelUp> ', -- Roda do mouse para cima
          NL = '<NL> ', -- Nova linha
          BS = '<BS> ', -- Tecla Backspace
          Space = '<Space> ', -- Tecla Espaço
          Tab = '<Tab> ', -- Tecla Tab
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>', -- Teclas de função F1-F12
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Documenta e agrupa os atalhos do líder (<leader>)
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } }, -- Atalhos relacionados a código
        { '<leader>d', group = '[D]ocument' }, -- Atalhos para documentação
        { '<leader>r', group = '[R]ename' }, -- Atalhos para renomeação
        { '<leader>s', group = '[S]earch' }, -- Atalhos para pesquisa
        { '<leader>w', group = '[W]orkspace' }, -- Atalhos para espaço de trabalho
        { '<leader>t', group = '[T]oggle' }, -- Atalhos para alternância de configurações
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- Atalhos para Git (Hunks)
      },
    },
  },
  {
    -- Fuzzy Finder (arquivos, LSP, etc.)
    'nvim-telescope/telescope.nvim',

    -- Carrega o plugin ao iniciar o Neovim
    event = 'VimEnter',

    -- Usa a branch 0.1.x do Telescope
    branch = '0.1.x',

    -- Dependências do Telescope
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        -- Extensão para integração com fzf (encontrador rápido)
        -- Se houver erros, veja o README do "telescope-fzf-native.nvim" para instruções de instalação
        'nvim-telescope/telescope-fzf-native.nvim',

        -- Executa "make" ao instalar ou atualizar o plugin
        build = 'make',

        -- Apenas instala o plugin se o comando "make" estiver disponível no sistema
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      {
        -- Extensão para melhorar o seletor UI
        'nvim-telescope/telescope-ui-select.nvim',
      },

      {
        -- Ícones bonitos para o Telescope (necessário Nerd Font)
        'nvim-tree/nvim-web-devicons',
        enabled = vim.g.have_nerd_font,
      },
    },

    config = function()
      -- [[ Configuração do Telescope ]]
      -- Veja `:help telescope` e `:help telescope.setup()`
      require('telescope').setup {
        -- Configuração de extensões do Telescope
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Ativa extensões do Telescope, se estiverem instaladas
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- [[ Atalhos para comandos do Telescope ]]
      -- Veja `:help telescope.builtin` para mais detalhes
      local builtin = require 'telescope.builtin'

      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' }) -- Busca nas tags de ajuda
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' }) -- Busca atalhos de teclas
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' }) -- Busca arquivos
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' }) -- Lista todas as funções do Telescope
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' }) -- Busca a palavra sob o cursor
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' }) -- Busca por texto dentro de arquivos
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' }) -- Mostra diagnósticos (LSP, erros, etc.)
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' }) -- Reabre a última busca do Telescope
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' }) -- Lista arquivos recentes
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' }) -- Busca entre buffers abertos

      -- Busca fuzzy no buffer atual (com layout personalizado)
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10, -- Transparência do menu
          previewer = false, -- Desativa o preview
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- Busca em arquivos abertos usando Grep
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true, -- Limita a busca a arquivos abertos
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Busca arquivos dentro da configuração do Neovim
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
  {
    -- `lazydev` configura o LSP para Lua no seu Neovim, incluindo sua configuração, runtime e plugins
    -- usado para autocompletar, anotações e assinaturas das APIs do Neovim
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Carrega os tipos da biblioteca luvit quando a palavra `vim.uv` for encontrada
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Configuração principal do LSP
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Instala automaticamente LSPs e ferramentas relacionadas no `stdpath` do Neovim
      -- O Mason deve ser carregado antes de seus dependentes, então precisamos configurá-lo aqui.
      -- OBSERVAÇÃO: `opts = {}` é o mesmo que chamar `require('mason').setup({})`
      {
        'williamboman/mason.nvim',
        opts = {
          ensure_installed = {
            '',
          },
        },
      },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Exibe atualizações úteis de status para o LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Adiciona recursos extras fornecidos pelo `nvim-cmp`
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Breve explicação: **O que é LSP?**
      --
      -- LSP (Language Server Protocol) é um protocolo que padroniza a comunicação entre
      -- editores e ferramentas de linguagem.
      --
      -- Em geral, você tem um "servidor" que entende uma linguagem específica
      -- (como `gopls`, `lua_ls`, `rust_analyzer`, etc.). Esses servidores LSP são
      -- processos independentes que se comunicam com um "cliente" – neste caso, o Neovim!
      --
      -- O LSP fornece ao Neovim funcionalidades como:
      --  - Ir para definição
      --  - Encontrar referências
      --  - Autocompletar
      --  - Pesquisa de símbolos
      --  - e muito mais!
      --
      -- Assim, os servidores LSP são ferramentas externas que precisam ser instaladas separadamente.
      -- É aqui que `mason` e seus plugins associados entram em ação.

      -- Esta função é executada quando um LSP é anexado a um buffer.
      -- Isso acontece sempre que um novo arquivo associado a um LSP é aberto
      -- (por exemplo, abrir `main.rs` ativa o `rust_analyzer`).
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- Definição de uma função para mapear atalhos LSP de forma mais fácil.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Atalhos para navegação e ações do LSP:
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Type [D]efinition')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]omear')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Realce referências ao passar o mouse sobre uma variável
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- Mapeamento para ativar/desativar "Inlay Hints" se suportado pelo servidor LSP
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Alterar símbolos de diagnóstico na coluna de sinais (gutter)
      -- Se estiver usando uma fonte Nerd Font, pode personalizar os ícones dos diagnósticos.
      if vim.g.have_nerd_font then
        local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
        local diagnostic_signs = {}
        for type, icon in pairs(signs) do
          diagnostic_signs[vim.diagnostic.severity[type]] = icon
        end
        vim.diagnostic.config { signs = { text = diagnostic_signs } }
      end

      -- Configurar recursos adicionais para os LSPs com `nvim-cmp`
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Lista de servidores LSP a serem ativados
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        ruff = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- Para evitar avisos ruidosos do `lua_ls`
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Garantir que os servidores e ferramentas acima sejam instalados
      local ensure_installed = vim.tbl_keys(servers or {})

      -- Utilizado para formatar código Lua
      vim.list_extend(ensure_installed, {
        'stylua',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      -- Configurar `mason-lspconfig` para gerenciar a instalação e configuração dos servidores LSP

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {} -- Obtém a configuração do servidor ou usa um objeto vazio

            -- Esta função lida com a substituição apenas de valores explicitamente passados
            -- pela configuração do servidor definida acima. Isso é útil para desativar
            -- certas funcionalidades de um LSP (por exemplo, desativar a formatação no `ts_ls`).
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

            -- Configura o LSP utilizando `lspconfig`
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  {
    -- Autoformat (Formatação automática)
    'stevearc/conform.nvim', -- Plugin responsável por formatar o código automaticamente
    event = { 'BufWritePre' }, -- Executa a formatação antes de salvar o buffer
    cmd = { 'ConformInfo' }, -- Adiciona o comando `:ConformInfo` para exibir informações sobre os formatadores disponíveis

    keys = {
      {
        '<leader>f', -- Atalho para formatar manualmente o buffer atual
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '', -- O modo aqui está vazio, o que significa que será aplicado a todos os modos suportados
        desc = '[F]ormat buffer', -- Descrição para facilitar a busca no `which-key` (se estiver usando)
      },
    },

    opts = {
      notify_on_error = false, -- Não exibe notificações quando a formatação falha

      format_on_save = function(bufnr)
        -- Define quais linguagens não devem usar formatação do LSP no salvamento automático
        -- Algumas linguagens, como C e C++, não possuem um padrão de formatação bem definido,
        -- então o LSP não será utilizado para formatá-las automaticamente.
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt

        -- Se o arquivo atual for C ou C++, desabilita o fallback do LSP para formatação
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never' -- Nunca usar o LSP para formatar esses arquivos
        else
          lsp_format_opt = 'fallback' -- Caso contrário, usar o fallback do LSP se um formatador não estiver disponível
        end

        return {
          timeout_ms = 500, -- Define um tempo limite de 500ms para a formatação
          lsp_format = lsp_format_opt, -- Aplica a configuração do LSP definida acima
        }
      end,
      formatters_by_ft = {
        -- Mapeia os formatadores para cada tipo de arquivo
        lua = { 'stylua' }, -- Usa `stylua` para formatar arquivos Lua

        -- Conform pode rodar múltiplos formatadores em sequência
        -- python = { "isort", "black" }, -- Primeiro `isort` e depois `black` para Python

        -- Pode-se usar `stop_after_first` para rodar apenas o primeiro formatador disponível
        -- javascript = { "prettierd", "prettier", stop_after_first = true }, -- Usa `prettierd` se disponível, senão `prettier`
      },
    },
  },
  {
    -- Autocompletar (AutoCompletion)
    'hrsh7th/nvim-cmp', -- Plugin principal de autocompletar para Neovim
    event = 'InsertEnter', -- Inicia o autocompletar quando entra no modo de inserção
    dependencies = {
      -- Motor de snippets e sua integração com `nvim-cmp`
      {
        'L3MON4D3/LuaSnip', -- Plugin para criar e utilizar snippets (trechos de código reutilizáveis)
        build = (function()
          -- Esta etapa de construção é necessária para suporte a expressões regulares em snippets.
          -- No Windows, essa etapa pode não ser suportada. Se necessário, remova a condição abaixo.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp' -- Instala suporte a expressões regulares nos snippets
        end)(),
        dependencies = {
          -- `friendly-snippets` contém snippets prontos para diversas linguagens e frameworks.
          -- Pode ser usado para carregar snippets automaticamente.
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load() -- Carrega snippets no formato VSCode
          --   end,
          -- },
        },
      },
      {
        'windwp/nvim-autopairs',
        opts_local = {
          fast_wrap = {},
          disable_filetype = { 'TelescopePrompt', 'vim' },
        },
        config = function(_, opts_local)
          require('nvim-autopairs').setup(opts_local)

          -- setup cmp for autopairs
          local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
          require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end,
      },
      'saadparwaiz1/cmp_luasnip', -- Integração entre `nvim-cmp` e `LuaSnip`

      -- Adiciona outras fontes de autocompletar
      'hrsh7th/cmp-nvim-lsp', -- Sugestões do LSP (Language Server Protocol)
      'hrsh7th/cmp-path', -- Permite completar caminhos de arquivos/diretórios
    },

    config = function()
      -- Importa os módulos necessários
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {} -- Configuração padrão do `LuaSnip`

      -- Configuração do `nvim-cmp`
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- Expande snippets enviados pelo LSP
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' }, -- Opções de comportamento do menu de sugestões

        -- Mapeamentos de teclas para navegar e selecionar sugestões
        mapping = cmp.mapping.preset.insert {

          -- Seleciona o próximo item da lista de sugestões
          ['<Tab>'] = cmp.mapping.select_next_item(),
          -- Seleciona o item anterior da lista de sugestões
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Rola a janela de documentação para cima ou para baixo
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Confirma a sugestão selecionada automaticamente
          -- Também ativa a importação automática se suportada pelo LSP
          ['<CR>'] = cmp.mapping.confirm { select = true },
          -- Caso prefira atalhos mais tradicionais para completar código,
          -- descomente estas linhas:
          --['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Atalho para ativar manualmente a lista de sugestões
          -- Normalmente não é necessário, pois o `nvim-cmp` exibe sugestões automaticamente.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- <C-l> e <C-h> são usados para navegar dentro dos snippets
          -- Exemplo: para um snippet de função como:
          -- function $name($args)
          --   $body
          -- end
          --
          -- <C-l> move para o próximo campo editável no snippet (`$args` → `$body`)
          -- <C-h> volta para o campo anterior.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- Para mais atalhos avançados do `LuaSnip`, veja:
          -- https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },

        -- Define as fontes de sugestões para o autocompletar
        sources = {
          {
            name = 'lazydev', -- Usa a fonte do `lazydev` para completar código Lua
            -- Define `group_index = 0` para evitar carregar sugestões do `lua_ls` junto com `lazydev`
            group_index = 0,
          },
          { name = 'nvim_lsp' }, -- Sugestões vindas do LSP
          { name = 'luasnip' }, -- Sugestões de snippets
          { name = 'path' }, -- Sugestões de caminhos de arquivos e diretórios
        },
      }
    end,
  },
  -- {
  --   -- Você pode facilmente mudar para um esquema de cores diferente.
  --   -- Basta alterar o nome do plugin do esquema de cores abaixo e, em seguida,
  --   -- alterar o comando na configuração para o nome do novo esquema de cores.
  --   --
  --   -- Se quiser ver quais esquemas de cores já estão instalados, use `:Telescope colorscheme`.
  --   'folke/tokyonight.nvim',
  --   priority = 1000, -- Certifique-se de carregar este antes de todos os outros plugins iniciais.
  --   init = function()
  --     -- Carrega o esquema de cores aqui.
  --     -- Como muitos outros temas, este tem diferentes estilos, e você pode carregar
  --     -- qualquer um deles, como 'tokyonight-storm', 'tokyonight-moon' ou 'tokyonight-day'.
  --     vim.cmd.colorscheme 'tokyonight-night'
  --
  --     -- Você pode configurar realces fazendo algo como:
  --     vim.cmd.hi 'Comment gui=none'
  --   end,
  -- },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
  },
  {
    -- Destaca palavras-chave como TODO, notas, etc., dentro de comentários
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  {
    -- Coleção de vários pequenos plugins/módulos independentes
    'echasnovski/mini.nvim',
    config = function()
      -- Melhorias em objetos de texto para seleção ao redor/dentro
      --
      -- Exemplos:
      --  - va)  - [V]isualmente selecionar [A]o redor de [)]parênteses
      --  - yinq - [Y]ank (copiar) [I]nterior do [N]ext (próximo) [Q]uote (entre aspas)
      --  - ci'  - [C]hange (alterar) [I]nterior de [']aspas
      require('mini.ai').setup { n_lines = 500 }

      -- Adicionar/remover/substituir elementos ao redor (parênteses, aspas, etc.)
      --
      -- - saiw) - [S]urround (envolver) [A]dicionar [I]nterior de [W]ord (palavra) [)]Parênteses
      -- - sd'   - [S]urround (envolver) [D]eletar [']aspas
      -- - sr)'  - [S]urround (envolver) [R]esubstituir [)] [']
      require('mini.surround').setup()

      -- Barra de status simples e fácil.
      --  Você pode remover esta chamada de configuração se não gostar,
      --  e experimentar algum outro plugin de barra de status
      local statusline = require 'mini.statusline'
      -- Defina `use_icons` como `true` se você tiver uma Nerd Font instalada
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- Você pode configurar seções na barra de status sobrescrevendo seu
      -- comportamento padrão. Por exemplo, aqui definimos a seção para
      -- exibir a posição do cursor no formato LINHA:COLUNA
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... e há muito mais!
      --  Confira: https://github.com/echasnovski/mini.nvim
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup()
    end,
  },
  {
    -- Realce, edição e navegação no código
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Define o módulo principal a ser usado para `opts`
    -- [[ Configuração do Treesitter ]] Veja `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'python',
        'cpp',
        'java',
        'typescript',
        'toml',
        'yaml',
        'dockerfile',
      },
      -- Instala automaticamente linguagens que ainda não estão instaladas
      auto_install = true,
      highlight = {
        enable = true,
        -- Algumas linguagens dependem do sistema de realce por regex do Vim (como Ruby) para regras de indentação.
        -- Se estiver enfrentando problemas estranhos de indentação, adicione a linguagem à lista de
        -- `additional_vim_regex_highlighting` e desative a indentação para essa linguagem.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- Existem módulos adicionais do `nvim-treesitter` que você pode usar para interagir
    -- com o `nvim-treesitter`. Vale a pena explorar alguns e ver o que te interessa:
    --
    --    - Seleção incremental: Incluído, veja `:help nvim-treesitter-incremental-selection-mod`
    --    - Exibir o contexto atual do cursor: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + objetos de texto: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  -- Os comentários a seguir só funcionarão se você tiver baixado o repositório `kickstart`,
  -- e não apenas copiado e colado o `init.lua`. Se quiser esses arquivos, eles estão no repositório,
  -- então basta baixá-los e colocá-los nos locais corretos.

  -- OBSERVAÇÃO: Próximo passo na sua jornada com o Neovim: Adicione/configure plugins adicionais para o Kickstart
  --
  --  Aqui estão alguns exemplos de plugins incluídos no repositório Kickstart.
  --  Descomente qualquer uma das linhas abaixo para ativá-los (você precisará reiniciar o Neovim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adiciona atalhos recomendados para `gitsigns`

  -- OBSERVAÇÃO: A importação abaixo pode adicionar automaticamente seus próprios plugins, configurações, etc.,
  -- a partir de `lua/custom/plugins/*.lua`
  --    Essa é a maneira mais fácil de modularizar sua configuração.
  --
  --  Descomente a linha abaixo e adicione seus plugins em `lua/custom/plugins/*.lua` para começar.
  -- { import = 'custom.plugins' },
  --
  -- Para informações adicionais sobre carregamento, sourcing e exemplos veja `:help lazy.nvim-🔌-plugin-spec`
  -- Ou use o `telescope`!
  -- No modo normal, digite `<space>sh` e então escreva `lazy.nvim-plugin`
  -- Você pode continuar na mesma janela com `<space>sr`, que retoma a última busca do `telescope`
}, {
  ui = {
    -- Se estiver usando uma Nerd Font: defina `icons` como uma tabela vazia `{}`,
    -- que usará os ícones padrão definidos pelo `lazy.nvim`. Caso contrário, defina uma tabela de ícones Unicode.
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '🗓',
      ft = '',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '☽',
      source = '🗎 ',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- Configuração do tema
vim.cmd.colorscheme 'catppuccin-mocha'

-- Configuração nvim-tree
require('nvim-tree').setup {
  filters = { dotfiles = false },
  disable_netrw = true,
  hijack_cursor = true,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    width = 30,
    preserve_window_proportions = true,
  },
  renderer = {
    root_folder_label = false,
    highlight_git = true,
    indent_markers = { enable = true },
    icons = {
      glyphs = {
        default = '󰈚',
        folder = {
          default = '',
          empty = '',
          empty_open = '',
          open = '',
          symlink = '',
        },
        git = { unmerged = '' },
      },
    },
  },
}

vim.keymap.set('n', '\\', '<cmd>NvimTreeToggle<CR>', { desc = 'Nvimtree toggle window' })
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeFocus<CR>', { desc = 'Nvimtree focus window' })
