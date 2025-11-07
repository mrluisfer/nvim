# Neovim Configuración Simple (Estilo VSCode)

## ⚡ Sobre esta configuración

Esta es una configuración minimalista de Neovim que imita la funcionalidad y los atajos de teclado de VSCode.
Incluye solo los plugins esenciales para una experiencia de desarrollo moderna y eficiente.

## 🎯 Características principales

- **Explorador de archivos**: Neo-tree con `Ctrl+B`
- **Búsqueda de archivos**: Telescope con `Ctrl+P`
- **Autocompletado**: nvim-cmp con LSP
- **Resaltado de sintaxis**: TreeSitter
- **Interfaz limpia**: Lualine + Tokyo Night theme
- **Atajos familiares**: Similares a VSCode

## 📦 Plugins incluidos (mínimos)

- **neo-tree.nvim**: Explorador de archivos
- **telescope.nvim**: Búsqueda de archivos y contenido
- **nvim-cmp**: Autocompletado inteligente
- **nvim-lspconfig**: Soporte para Language Server Protocol
- **mason.nvim**: Gestión automática de LSP servers
- **nvim-treesitter**: Resaltado de sintaxis avanzado
- **tokyonight.nvim**: Tema visual
- **lualine.nvim**: Barra de estado

## ⌨️ Atajos de teclado (estilo VSCode)

### Navegación de archivos

- `Ctrl+B`: Abrir/cerrar explorador de archivos
- `Ctrl+P`: Buscar archivos
- `Ctrl+Shift+F`: Buscar en archivos
- `Ctrl+Shift+P`: Paleta de comandos

### Edición

- `Ctrl+A`: Seleccionar todo
- `Ctrl+S`: Guardar archivo
- `Ctrl+N`: Nuevo archivo
- `Ctrl+W`: Cerrar archivo
- `Ctrl+/`: Comentar/descomentar línea
- `Shift+Alt+Down`: Duplicar línea hacia abajo
- `Alt+Up/Down`: Mover línea arriba/abajo

### Navegación entre buffers

- `Ctrl+Tab`: Siguiente buffer
- `Ctrl+Shift+Tab`: Buffer anterior

### LSP (Language Server)

- `gd`: Ir a definición
- `K`: Mostrar documentación
- `F2`: Renombrar símbolo
- `Ctrl+.`: Acciones de código

## 🚀 Instalación

### 1. Instalar Neovim (versión 0.8+)

**macOS:**

```bash
brew install neovim
```

**Ubuntu/Debian:**

```bash
sudo apt update && sudo apt install neovim
```

### 2. Clonar esta configuración

```bash
# Hacer backup de tu configuración actual (si existe)
mv ~/.config/nvim ~/.config/nvim.backup

# Clonar esta configuración
git clone https://github.com/mrluisfer/nvim ~/.config/nvim
```

### 3. Abrir Neovim

La primera vez que abras Neovim, lazy.nvim instalará automáticamente todos los plugins:

```bash
nvim
```

### 4. Instalar Language Servers (opcional)

Los LSP servers se instalan automáticamente con Mason cuando abres un archivo del lenguaje correspondiente.
Los incluidos por defecto son:

- `lua_ls`: Para Lua
- `ts_ls`: Para TypeScript/JavaScript

## 🔧 Personalización

El archivo principal de configuración es `init.lua`. Puedes:

1. **Agregar más LSP servers**: Modifica la lista en `ensure_installed`
2. **Cambiar tema**: Reemplaza `tokyonight` por otro tema
3. **Agregar plugins**: Añade nuevas entradas en la tabla de `require("lazy").setup()`
4. **Modificar atajos**: Actualiza la sección de keymaps

## 🆘 Solución de problemas

### Los atajos no funcionan

- Verifica que tu terminal soporte los atajos de teclado (especialmente Ctrl+Shift)
- Algunos terminales requieren configuración adicional para Ctrl+/

### LSP no funciona

- Ejecuta `:Mason` para ver el estado de los language servers
- Ejecuta `:LspInfo` para diagnosticar problemas de LSP

### Plugins no se cargan

- Ejecuta `:Lazy` para ver el estado de los plugins
- Ejecuta `:Lazy sync` para actualizar plugins

## 🤝 Contribuir

Si encuentras algún problema o tienes sugerencias:

1. Abre un issue
2. Envía un pull request
3. Comparte tus mejoras

## 📝 Licencia

MIT License - Siéntete libre de usar y modificar esta configuración.
