bashly="docker run --rm -it --user $(id -u):$(id -g) --volume $PWD:/app dannyben/bashly"
task -d "cd /etc/nixos/overlays/pkgs/nixos-cli && bashly generate"
(cd /etc/nixos/overlays/pkgs/nixos-cli && $bashly generate)

