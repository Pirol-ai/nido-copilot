# nido for GitHub Copilot

**nido** runs code in isolated sandboxes: each one is a small virtual machine of its own, in the EU,
run by [Pirol](https://pirol.ai). This plugin teaches GitHub Copilot when and how to use them — so you can
say *"try this in a sandbox"* or *"fine-tune this on a GPU"*, and GitHub Copilot creates the sandbox, runs
the work there, copies the results back and cleans up.

GitHub Copilot drives nido the way you would: with the `nido` command line on your computer, as you, with
your account and your budget. Nothing new runs in the background.

## What you need

The **nido command line**, version 0.7.4 or newer (Node 20 or newer), installed and logged in once:

```bash
npm install -g @pirol/nido
nido login
```

`nido login` opens your browser and you confirm with your Pirol account. GitHub Copilot never sees a key.

> **Closed beta.** Sandboxes are open to invited accounts. Ask for access at
> [hello@pirol.ai](mailto:hello@pirol.ai).

## Install

For the Copilot CLI:

```bash
copilot plugin marketplace add Pirol-ai/nido-copilot && copilot plugin install nido@nido-copilot
```

Start a new Copilot session afterwards. The skill is called `nido`; Copilot uses it on its own
when a task fits. `copilot plugin list` shows the plugin, `copilot skill list` the skill.

The skill is a standard [Agent Skill](https://agentskills.io). In VS Code with Copilot, copy the
`skills/nido` folder to `~/.copilot/skills/nido` (for you) or `.github/skills/nido` (for one
repository).

## Use it

Ask in plain words. A few prompts to start with:

- *"Run the test suite in a nido sandbox, not on my machine."*
- *"Clone this repo into a sandbox and check whether `npm install` runs any install scripts."*
- *"Start Postgres in one sandbox and our API in another, connected, and run the integration tests."*
- *"Fine-tune Qwen2.5-0.5B with LoRA on `data/tickets.jsonl` on an L4 GPU, then bring the adapter back."*
- *"Which sandboxes are still running? Remove the ones from today."*

GitHub Copilot checks that nido is installed and logged in, asks before it installs nido or starts a GPU,
opens only the network hosts and secrets the task needs, and removes the sandboxes it created when
the work is done.

## Let it run nido without asking

Copilot asks before every shell command. To let it run nido without asking, start it with:

```bash
copilot --allow-tool='shell(nido:*)'
```

That allows every nido command, including creating and removing sandboxes. Leave it out if you
want to approve each one.

## What it runs, sends and stores

- **Runs:** only the `nido` command on your computer, when GitHub Copilot decides to call it. This
  plugin adds instructions, no server and no background process.
- **Sends:** what you copy into a sandbox with `nido cp` goes to that sandbox, in the EU. What a
  command in the sandbox prints goes back to GitHub Copilot and from there to its model, as with any
  command it runs.
- **Stores:** nothing of its own. nido keeps its login key in `~/.nido/config.json`.
- **Costs:** sandboxes are billed from your Pirol budget while they run; GPUs cost more. Prices:
  [pirol.ai/pricing](https://pirol.ai/pricing#sandboxes).

## The same skill for every agent

The skill in `skills/nido` is the same in all five nido integrations:
[Claude Code](https://github.com/Pirol-ai/nido-claude-code),
[Codex](https://github.com/Pirol-ai/nido-codex),
[GitHub Copilot](https://github.com/Pirol-ai/nido-copilot),
[OpenCode](https://github.com/Pirol-ai/nido-opencode) and
[Qwen Code](https://github.com/Pirol-ai/nido-qwen-code).
Any other agent that runs shell commands can use it too: copy the folder to wherever it reads
skills.

## Checking it

`sh check.sh` installs the plugin into a throwaway `HOME`, so your own Copilot is not touched,
and checks that Copilot lists the plugin and its skill. It needs `copilot` and `node`.
`node --test tests/*.test.mjs` checks the manifest alone and runs on every pull request.

## Support

Questions and problems: [github.com/Pirol-ai/nido-copilot/issues](https://github.com/Pirol-ai/nido-copilot/issues).
Documentation: [pirol.ai/docs/sandboxes](https://pirol.ai/docs/sandboxes) ·
Privacy: [pirol.ai/privacy](https://pirol.ai/privacy) · Terms: [pirol.ai/terms](https://pirol.ai/terms)

## License

MIT — see [LICENSE](LICENSE). The licence covers this plugin; the nido command line is licensed
separately.
