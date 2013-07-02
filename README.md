easygo
======

EasyGo。以Ruby的Goliath為核心，為個人簡易開發即時性且具高效能的Server而建立。

包含以下模組
----------

###Grape
做為easygo的Router機制

###Postgresql
與postgresql DB做連接

###Rspec、Guard、simplecov
單元測試、自動化測試、覆蓋率測試



######目前hack部分
主程式繼承Goliath::WebSocket而非Goliath::API

於server.rb覆寫on_body

```
  def on_body(env, data)
    if env.respond_to?(:handler)
      env.handler.receive_data(data)
    else
      env['params'] = data
    end
  end
```
如此 users.rb

```
    post '/create' do
      params = JSON.parse(env.params)
      User.create(params['user'])
    end
```
則可正常接收post request


參考範例
https://github.com/coshx/goliath-chat






