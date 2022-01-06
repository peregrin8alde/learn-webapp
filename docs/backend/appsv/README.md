# アプリケーション（ AP ）サーバー

Java 以外は Web サーバーやアプリそのもの、開発用フレームワークとの境界が分かりづらいので注意。

- PHP
  - PHP を実行するためのモジュールを有効にすることで Web サーバーと AP サーバーを兼任する。
- Java
  - アプリケーションサーバの標準規格として、 [Jakarta EE](https://jakarta.ee/) （旧 Java EE ）がある。
  - [Apache Tomcat](https://tomcat.apache.org/)
    - Jakarta EE の一部実装でしかないため、 REST API などはオプションモジュールを使う必要がある。そのため、ここでは軽くしか触れないものとする。
      - Web コンテナやサーブレットコンテナと呼ばれる範囲の機能。 `.war` ファイルを扱う。
    - Apache TomEE という実装範囲を広げたものもある。
  - [Eclipse GlassFish](https://glassfish.org/)
    - Jakarta EE と互換性のある実装（参照実装として他の見本となる）
    - Web コンテナに加え、 EJB コンテナと呼ばれる範囲（ビジネス・ロジック層）もカバー。
    - アプリケーションサーバ全体としては、 Web コンテナと EJB コンテナ合わせて `.ear` ファイルを扱う。
  - [Payara](https://www.payara.fish/)
    - Jakarta EE と互換性のある実装
    - クラウドネイティブを謳っており、公式から AWS などのクラウド連携やマイクロサービス、 Docker イメージなどに関する情報を得ることができる。
- JavaScript
  - Node.js
    - Node.js 自体は JavaScript 実行環境であり、 AP サーバーとしての機能を持ったスクリプトを実行することになる。
