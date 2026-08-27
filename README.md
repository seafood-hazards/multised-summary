# multised (summary)

The plain-English summary of the multised marine-sediment trace-element work:
background levels, pristine estimates and the aquaculture pressure test, in four
sections (Home, Methods, Results, Downloads).

It is the sixth and outermost layer of the project. It holds **no data of its
own** and computes **nothing**: every figure and table is read from CSVs written
by `analyze_data("refined", module = "summary")` in
[multised-engine](https://github.com/seafood-hazards/multised-engine), and
attached to a release of this repository.

- Live site: <https://seafood-hazards.github.io/multised-summary/>
- Detailed analysis: <https://seafood-hazards.github.io/multised-refined/>

## Publishing

Release assets must be uploaded **before** pushing `main`. CI renders from
`releases/latest/download/`, which does not fall back to an older release.

```bash
_scripts/publish-release.sh v0.1.0        # uploads everything in _scripts/release-assets.txt
git push origin main                      # then let CI render
```

`_scripts/release-assets.txt` is the single source of truth for what a release
must carry: `publish-release.sh` uploads what is listed there, and
`download_resources.R` fetches the same list at pre-render, so the two cannot
drift apart.

## Local render

```bash
mkdir -p data/summary
cp ../multised-engine/data/analysis/summary/*.csv data/summary/
quarto preview
```

The pre-render script reuses local copies if they exist, so nothing is downloaded
when the pipeline output is already in place.
