# odio-mympd

Build pipeline that produces multi-arch Debian packages of
[myMPD](https://github.com/jcorporation/myMPD) for the
[Odio APT repository](https://apt.odio.love).

This is **not a fork** — no source code is vendored here. The CI clones
the upstream tag, builds it inside per-arch builder images, and publishes
`.deb` artifacts as a GitHub Release.

## Architectures

- `amd64` (Debian trixie)
- `arm64` (Raspberry Pi OS)
- `armhf` (Raspberry Pi OS)

## Releasing

Tag this repo with the upstream version to release:

```bash
git tag v25.0.1 && git push origin v25.0.1
```

A prerelease (routed to the `testing` channel of the APT repo) uses a
suffix; the underlying upstream tag is the same:

```bash
git tag v25.0.1-rc1 && git push origin v25.0.1-rc1
```

The CI strips `-rc<N>`, `-beta<N>`, `-alpha<N>` to resolve the upstream
tag, marks the GitHub Release as a prerelease, and dispatches a rebuild
of `odio-apt-repo`.

## Builder images

Pre-baked images on GHCR speed up the QEMU-emulated ARM builds. They are
rebuilt automatically when `docker/builder.Dockerfile` changes, monthly,
or on demand:

```bash
gh workflow run build-images.yml
```

## License

The build scripts and Dockerfile in this repo are licensed under the
[MIT License](LICENSE). The produced packages contain compiled myMPD,
which is licensed
[GPL-3.0-or-later](https://github.com/jcorporation/myMPD/blob/master/LICENSE.md).
