# Viagens Mobile

Aplicativo simples para consumo de API Spring.

## Comece

Se esta é sua primeira vez abrindo um projeto Flutter:

- [Siga os passos para o processo de instalação aqui](https://docs.flutter.dev/get-started/install)

Se houver falhas no sdkmanager durante a instalação:
- [Instale o sdkmanager utilizando prompt](https://developer.android.com/tools/sdkmanager?hl=pt-br)
- [Instale o sdkmanager utilizando Android Studio](https://developer.android.com/studio/intro/update)

## Versões
- Versão do SDK: 3.11.5 (Flutter)

> [!IMPORTANT]
> Uma vez a configuração finalizada, deve-se clonar o repositório e abrir o projeto com VS Code. Então deve-se baixar as dependências referentes a sua versão do SDK, para isso, abra o terminal pressionando CTRL + ' e digite:
```
  flutter pub get
```

## Depure seu app no seu dispositivo sem utilizar cabo
### Para começar, adicione o pacote adb nas suas variáveis de ambiente:
- Acesse o local onde está instalado o Android no seu computador. Copie o caminho "(...)\Android\Sdk\platform-tools" e o adicione como variável de ambiente no seu Sistema Operacional.
- Reinicie o terminal e conecte seu celular no computador. Abra as configurações do WI-FI do seu dispositivo móvel e procure pela porta da conexão que estará no padrão 172.100.123.500:**41773**.
```
  adb tcpip 41773
```

```
  adb connect 172.100.123.500:41773
```


> [!NOTE]
> Altere o valor "172.100.123.500" para o IP da sua conexão.
- Agora, seu dispositivo pode ser visualizado na conexão USB e WI-FI em:
```
  adb devices
```


- Retire o cabo e seu celular está pronto para a depuração sem cabo!

> [!CAUTION]
> Desligue qualquer VPN ligada em quaisquer dispositivos que participarão da conexão.

### Dúvidas?
[Testar Flutter por WiFi - Conectar Android SEM Cabo USB no Flutter](https://www.youtube.com/watch?v=XFWig8VAS4E)



### NOTAS DO TESTE
Infelizmente, não pude rodar o projeto em um celular (nem emulador) e, por isso, desenvolvi todo o app testando pelo Chrome (ativando a visualização iPhone 14 Pro Max).
Decidi avisar por aqui caso encontre algum problema de UI.
