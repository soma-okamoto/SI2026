# 作成した予稿

- `SICE-SI_manuscript.pdf`：A4・2段組・2ページの確認用／提出用原稿。
- `SICE-SI_manuscript.tex`：編集用LaTeXソース。
- `manuscript_references.bib`：MASK論文、共分散交差法（Julier・Uhlmann，1997）、マハラノビス距離（Mahalanobis，1936）の参考文献情報。

Sampleと同じ `sice-si.cls`、`sice.bbx`、`sice.cbx` を使用しています。
原稿は研究背景、事前Place位置分布、Place後の観測による位置推定、MRボトルの局所補正、結言の順です。
実験結果や測定値は追加していません。評価は今後の課題として記述しています。
著者・所属は指定の情報を反映し、登壇者の○は第一著者の岡本宗馬氏に付けています。

## このWindows環境での再生成

このフォルダで次のコマンドを実行してください。

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\build_manuscript.ps1
```

このコマンドの実行ポリシー指定は起動するプロセスにだけ適用されます。
スクリプトはLuaLaTeXとupBibTeXを使用し、完成PDFをフォルダ直下へ配置します。
補助ファイルは `.manuscript-build` に出力します。
実行中に設定する環境変数は、終了時に元へ戻します。

この環境で不足していた `newtx` と `kastrup` は `.texmf` に導入しました。
`.texmf-var` と `.texmf-config` はこの原稿用のキャッシュ・設定領域です。
元のSample、クラスファイルおよび `.latexmkrc` は変更していません。

## 別のLaTeX環境での利用

必要なパッケージが導入済みなら、原稿ソース、参考文献ファイル、
`sice-si.cls`、`sice.bbx`、`sice.cbx` を同じフォルダに配置し、
LuaLaTeX → upBibTeX → LuaLaTeX → LuaLaTeX の順でコンパイルできます。
BibLaTeXは、Biber未導入の環境でも生成できるよう `backend=bibtex` を指定しています。
`manuscript.latexmkrc` を使う場合は次のコマンドです。

```text
latexmk -norc -r manuscript.latexmkrc SICE-SI_manuscript.tex
```

この場合のPDFは `.manuscript-build/SICE-SI_manuscript.pdf` です。
