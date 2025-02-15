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

-- Atalho para limpar a busca ao pressionar <Esc>
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Atalho para abrir a lista de diagnósticos
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Abrir lista de diagnósticos [Q]uickfix' })

-- Atalho para sair do modo terminal pressionando <Esc><Esc>
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Sair do modo terminal' })

-- Destacar o texto ao copiar (yank)
-- Teste com `yap` no modo normal
-- Veja `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Destacar texto ao copiar',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({
	higroup = 'IncSearch', -- Usa a cor do IncSearch para destacar
	timeout = 200 -- Destaca por 200ms
    })
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



