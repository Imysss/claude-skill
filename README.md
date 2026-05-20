# claude-skill

Claude Code 사용자 스킬 모음. Team Sparta 게임팀 내부용.

## 포함된 스킬

- **qa-testcase-notion** — 개발 완료된 기능의 QA 테스트케이스를 Notion DB에
  자동으로 추가. 코드 변경(커밋/PR diff)을 분석해 QA 친화 표현으로 변환한 뒤
  미리 복제한 TC 템플릿 페이지의 inline DB에 행을 채워 넣는다.

## 설치

### 방법 A — 자동 설치 (권장)

```bash
git clone https://github.com/Imysss/claude-skill.git ~/dev/claude-skill
cd ~/dev/claude-skill
./install.sh
```

`install.sh` 가 각 스킬 디렉토리를 `~/.claude/skills/` 에 symlink 로 걸기
때문에 이후 `git pull` 만 받으면 자동으로 업데이트가 반영된다.

### 방법 B — 수동 복사

```bash
git clone https://github.com/Imysss/claude-skill.git
cp -R claude-skill/qa-testcase-notion ~/.claude/skills/
```

### 확인

Claude Code 를 새 세션으로 띄우고 임의의 메시지를 보낸 뒤 시스템 프롬프트의
스킬 목록에 `qa-testcase-notion` 이 등장하는지 확인. 등장하면 설치 성공.

## 사용

### qa-testcase-notion

Notion 에서 [TC 템플릿] 페이지를 복제해 빈 QA 페이지를 만든 뒤, Claude Code 에
다음과 같이 요청:

```
최근 X 기능 관련 노션에 TC 추가해줘
URL: https://www.notion.so/teamsparta/QA-...
```

스킬이 자동 발동되며:
1. diff 분석 후 QA 친화 표현으로 케이스 도출 (jargon glossary 적용)
2. **클러스터 표 + 케이스 표** 두 단계로 미리보기 → 사용자 승인 대기
3. 승인되면 Notion DB 에 행 일괄 추가 + view 정렬 (`SORT BY "번호" ASC`) 자동 적용

자세한 룰은 [qa-testcase-notion/SKILL.md](qa-testcase-notion/SKILL.md) 참고.

## 의존성

- Claude Code
- Notion MCP 서버 (workspace 내 페이지 접근 권한 필요)

## 업데이트

```bash
cd ~/dev/claude-skill && git pull
```

symlink 설치(방법 A)였다면 자동 반영. 수동 복사였다면 `~/.claude/skills/` 에
다시 복사 필요.
