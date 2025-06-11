# klog-deploy Zsh Plugin

Tail logs (`kubectl logs -f`) for **all pods in a Kubernetes deployment**, with:

- 🧠 Auto-detected current namespace
- 📦 `fzf` deployment picker (optional)
- 🎨 Colored `[pod-name]` prefixes
- 🔚 Clean Ctrl+C termination

## Installation (for Oh My Zsh)

```bash
cd ~/.oh-my-zsh/custom/plugins
git clone <this plugin or copy it manually>
