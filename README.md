# OmnisCode-infra
- OpenHackU vol.5 さぼてんとゆかいな仲間たち OmnisCodeのインフラリポジトリ
- 基本的に、サーバに関わる作り直しが発生しそうなものについてはcodeで書いておく。他は手で作ってもよいことにする。

## 手で作ったもの
- firebase project(Authentication)
- GCRの有効化

## ansible

```
ansible-playbook -i inventory playbook.yml
```

## note
- GCR 権限 https://cloud.google.com/container-registry/docs/advanced-authentication?hl=ja
