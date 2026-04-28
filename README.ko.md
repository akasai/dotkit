# dotkit

개인 dotfiles 패키지 매니저. 필요한 세팅만 골라 설치하고, 모든 PC를 동일하게 유지.

## 설치

```bash
curl -fsSL https://raw.githubusercontent.com/akasai/dotkit/main/setup.sh | bash
```

또는 직접 클론:

```bash
git clone git@github.com:akasai/dotkit.git ~/.dotkit
~/.dotkit/dotkit install all
```

## 사용법

```bash
dotkit install zsh opencode    # 원하는 모듈만 설치
dotkit install all             # 전체 설치
dotkit update                  # 최신 pull + 재링크
dotkit list                    # 모듈 목록 및 설치 상태
dotkit status                  # 심링크 상태 점검
dotkit uninstall <module>      # 제거 + 원본 복구
```

## 모듈

| 모듈 | 대상 경로 | 내용 |
|------|----------|------|
| `zsh` | `~/` | `.zshrc` |
| `opencode` | `~/.config/opencode/` | oh-my-openagent, plugins, skills, presets |
| `claude` | `~/.claude/` | `CLAUDE.md`, skills |
| `git` | `~/` | `.gitconfig` |

## 동작 방식

각 모듈은 `modules/<name>/` 아래 `module.sh`(메타데이터 + 훅)과 `files/` 디렉터리로 구성된다. `dotkit install`은 `files/` 내 항목을 대상 경로에 심링크로 연결한다.

- 기존 파일은 `.dotkit-backup`으로 백업
- `dotkit uninstall`은 심링크 제거 후 백업 복구
- `dotkit update`는 repo pull 후 설치된 모듈 전체 재링크
- 심링크된 파일 수정 시 변경 사항이 이 repo에 직접 반영

## 모듈 추가

```bash
mkdir -p modules/mymodule/files
```

`modules/mymodule/module.sh` 작성:

```bash
MODULE_NAME="mymodule"
MODULE_DESC="간단한 설명"
MODULE_TARGET="${HOME}/.config/mymodule"
```

관리할 파일을 `modules/mymodule/files/`에 넣고 `dotkit install mymodule` 실행.

## 요구 사항

- git
- bash 3.2+ (macOS 기본 bash 호환)
- npm (opencode 모듈 전용)
