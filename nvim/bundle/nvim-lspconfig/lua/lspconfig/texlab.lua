local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'
local lsp = vim.lsp

local texlab_build_status = vim.tbl_add_reverse_lookup {
  Success = 0;
  Error = 1;
  Failure = 2;
  Cancelled = 3;
}

local texlab_forward_status = vim.tbl_add_reverse_lookup {
  Success = 0;
  Error = 1;
  Failure = 2;
  Unconfigured = 3;
}

local function buf_build(bufnr)
  bufnr = util.validate_bufnr(bufnr)
  local params = { textDocument = { uri = vim.uri_from_bufnr(bufnr) }  }
  lsp.buf_request(bufnr, 'textDocument/build', params,
      function(err, _, result, _)
        if err then error(tostring(err)) end
        print("Build "..texlab_build_status[result.status])
      end)
end

local function buf_search(bufnr)
  bufnr = util.validate_bufnr(bufnr)
  local params = { textDocument = { uri = vim.uri_from_bufnr(bufnr) }, position = { line = vim.fn.line('.')-1, character = vim.fn.col('.')  }}
  lsp.buf_request(bufnr, 'textDocument/forwardSearch', params,
      function(err, _, result, _)
        if err then error(tostring(err)) end
        print("Search "..texlab_forward_status[result.status])
      end)
end

-- bufnr isn't actually required here, but we need a valid buffer in order to
-- be able to find the client for buf_request.
-- TODO find a client by looking through buffers for a valid client?
-- local function build_cancel_all(bufnr)
--   bufnr = util.validate_bufnr(bufnr)
--   local params = { token = "texlab-build-*" }
--   lsp.buf_request(bufnr, 'window/progress/cancel', params, function(err, method, result, client_id)
--     if err then error(tostring(err)) end
--     print("Cancel result", vim.inspect(result))
--   end)
-- end

configs.texlab = {
  default_config = {
    cmd = {"texlab"};
    filetypes = {"tex", "bib"};
    root_dir = function(filename)
      return util.path.dirname(filename)
    end;
    settings = {
      texlab = {
        rootDirectory = nil;
        build = {
          executable = "latexmk";
          args = {"-pdf", "-interaction=nonstopmode", "-synctex=1", "%f"};
          isContinuous = false;
        };
        auxDirectory = '.';
        forwardSearch = {
          executable = nil;
          args = {};
        };
        chktex = {
          onOpenAndSave = false;
          onEdit = false;
        };
        diagnosticsDelay = 300;
        bibtexFormatter = 'texlab';
        formatterLineLength = 80;
      };
    };
  };
  commands = {
    TexlabBuild = {
      function()
        buf_build(0)
      end;
      description = "Build the current buffer";
    };
    TexlabForward = {
      function()
          buf_search(0)
      end;
      description = "Forward search from current position";
    }
  };
  docs = {
    description = [[
https://github.com/latex-lsp/texlab

A completion engine built from scratch for (La)TeX.

See https://github.com/latex-lsp/texlab/docs/options.md for configuration options.
]];
    default_config = {
      root_dir = "vim's starting directory";
    };
  };
}

configs.texlab.buf_build = buf_build
configs.texlab.buf_search = buf_search
-- vim:et ts=2 sw=2
