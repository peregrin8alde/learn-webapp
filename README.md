# webapp

Webアプリ開発関連技術の勉強用

- Web アプリ本体だけではなく、 DB や フロントエンド、 API 、認証などとの連携も含める。
- 各種言語やフレームワーク、ツールの種類を切り替え可能なように、できるだけ疎結合なサンプルアプリを作成する。
  - プラグインやアダプタ、インターフェースによるカプセル化など
- 最終的にプロセス毎に Docker コンテナとして起動する想定

以下の操作を実装する。

1. Web アプリ用のサイトにアクセス
2. ログイン
3. 何らかのサービスを提供
   1. 最低限、データの登録、参照、編集、削除
      1. 扱うデータはテキスト、画像、音声、その他
   2. 内部でデータ処理のために DB アクセスや API 実行などを実施
   3. GUI だけではなく RESTful API も提供
4. ログアウト


## Getting started

To make it easy for you to get started with GitLab, here's a list of recommended next steps.

Already a pro? Just edit this README.md and make it your own. Want to make it easy? [Use the template at the bottom](#editing-this-readme)!

## Add your files

- [ ] [Create](https://gitlab.com/-/experiment/new_project_readme_content:9bf7a6242bfe21c653edeb0fdb795ed6?https://docs.gitlab.com/ee/user/project/repository/web_editor.html#create-a-file) or [upload](https://gitlab.com/-/experiment/new_project_readme_content:9bf7a6242bfe21c653edeb0fdb795ed6?https://docs.gitlab.com/ee/user/project/repository/web_editor.html#upload-a-file) files
- [ ] [Add files using the command line](https://gitlab.com/-/experiment/new_project_readme_content:9bf7a6242bfe21c653edeb0fdb795ed6?https://docs.gitlab.com/ee/gitlab-basics/add-file.html#add-a-file-using-the-command-line) or push an existing Git repository with the following command:

```
cd existing_repo
git remote add origin https://gitlab.com/peregrin8alde-grp/learning/webapp.git
git branch -M main
git push -uf origin main
```

## Integrate with your tools

- [ ] [Set up project integrations](https://gitlab.com/-/experiment/new_project_readme_content:9bf7a6242bfe21c653edeb0fdb795ed6?https://gitlab.com/peregrin8alde-grp/learning/webapp/-/settings/integrations)

## Collaborate with your team

- [ ] [Invite team members and collaborators](https://gitlab.com/-/experiment/new_project_readme_content:9bf7a6242bfe21c653edeb0fdb795ed6?https://docs.gitlab.com/ee/user/project/members/)
- [ ] [Create a new merge request](https://gitlab.com/-/experiment/new_project_readme_content:9bf7a6242bfe21c653edeb0fdb795ed6?https://docs.gitlab.com/ee/user/project/merge_requests/creating_merge_requests.html)
- [ ] [Automatically close issues from merge requests](https://gitlab.com/-/experiment/new_project_readme_content:9bf7a6242bfe21c653edeb0fdb795ed6?https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues-automatically)
- [ ] [Enable merge request approvals](https://gitlab.com/-/experiment/new_project_readme_content:9bf7a6242bfe21c653edeb0fdb795ed6?https://docs.gitlab.com/ee/user/project/merge_requests/approvals/)
- [ ] [Automatically merge when pipeline succeeds](https://gitlab.com/-/experiment/new_project_readme_content:9bf7a6242bfe21c653edeb0fdb795ed6?https://docs.gitlab.com/ee/user/project/merge_requests/merge_when_pipeline_succeeds.html)

## Test and Deploy

Use the built-in continuous integration in GitLab.

- [ ] [Get started with GitLab CI/CD](https://gitlab.com/-/experiment/new_project_readme_content:9bf7a6242bfe21c653edeb0fdb795ed6?https://docs.gitlab.com/ee/ci/quick_start/index.html)
- [ ] [Analyze your code for known vulnerabilities with Static Application Security Testing(SAST)](https://gitlab.com/-/experiment/new_project_readme_content:9bf7a6242bfe21c653edeb0fdb795ed6?https://docs.gitlab.com/ee/user/application_security/sast/)
- [ ] [Deploy to Kubernetes, Amazon EC2, or Amazon ECS using Auto Deploy](https://gitlab.com/-/experiment/new_project_readme_content:9bf7a6242bfe21c653edeb0fdb795ed6?https://docs.gitlab.com/ee/topics/autodevops/requirements.html)
- [ ] [Use pull-based deployments for improved Kubernetes management](https://gitlab.com/-/experiment/new_project_readme_content:9bf7a6242bfe21c653edeb0fdb795ed6?https://docs.gitlab.com/ee/user/clusters/agent/)
- [ ] [Set up protected environments](https://gitlab.com/-/experiment/new_project_readme_content:9bf7a6242bfe21c653edeb0fdb795ed6?https://docs.gitlab.com/ee/ci/environments/protected_environments.html)
