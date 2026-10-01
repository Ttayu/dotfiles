return {
  on_attach = function(client, bufnr)
    -- 1. 補完を無効化
    client.server_capabilities.completionProvider = false
    -- 2. ホバー表示を無効化
    client.server_capabilities.hoverProvider = false
    -- 3. 定義ジャンプを無効化 (必要に応じて)
    client.server_capabilities.definitionProvider = false
    -- 4. 参照検索を無効化 (必要に応じて)
    client.server_capabilities.referencesProvider = false
    -- 5. シグネチャヘルプを無効化 (必要に応じて)
    client.server_capabilities.signatureHelpProvider = false
    -- note: client.server_capabilities.codeActionProvider は
    -- デフォルトで true なので、ここでは触れずに有効なままにします。
  end,
  settings = {
    basedpyright = {
      -- disableLanguageServices = true,
      -- disableOrganizeImports = true,
      analysis = {
        typeCheckingMode = 'basic',
      }
    }
  }
}
