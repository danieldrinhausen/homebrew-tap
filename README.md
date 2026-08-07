# danieldrinhausen/homebrew-tap

A [Homebrew](https://brew.sh) tap with one cask:
[Tokenmax](https://github.com/danieldrinhausen/Tokenmax), a macOS menu bar app
showing remaining Claude Code and Codex quota.

```sh
brew install --cask danieldrinhausen/tap/tokenmax
```

That is the whole tap. `brew upgrade --cask tokenmax` follows new releases;
`brew uninstall --zap --cask tokenmax` also removes the queue, settings and
logs under `~/Library/Application Support/Tokenmax`.

## The first launch still needs one click

Tokenmax is signed but not notarized — notarization needs a paid Apple
Developer account — so macOS refuses the first launch and wants **System
Settings → Privacy & Security → Open Anyway**. Installing through Homebrew does
not change that: `brew` quarantines downloads by default, exactly as a browser
would. The app then asks once for access to the `Claude Code-credentials`
keychain item, which is how it reads your quota.

Both prompts return after an upgrade, because macOS binds each decision to the
exact binary. The
[README](https://github.com/danieldrinhausen/Tokenmax#install) explains why in
more detail.

## How this stays current

`.github/workflows/update-cask.yml` polls the Tokenmax repo hourly and commits
a new `version`/`sha256` when a release appears, so nothing here needs a token
that can expire. Right after publishing a release you can skip the wait:

```sh
gh workflow run update-cask.yml -R danieldrinhausen/homebrew-tap
```

Locally, `./bin/update-cask` does the same thing to your working copy.

Two things can quietly stop the automatic half, and neither stops the manual
one: GitHub disables `schedule` triggers in a repository that has seen no
activity for 60 days, and the commit step needs **Settings → Actions → General →
Workflow permissions → Read and write**. A tap that only changes on release days
is exactly the shape of repository that goes quiet for two months, so treat the
`workflow run` above as the real mechanism and the schedule as the backstop.
