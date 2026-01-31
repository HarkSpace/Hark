---
name: hark-skill
description: "Hark project skill for frontend (Vue 3 + Vite + UnoCSS + Naive UI/Vant), backend (Tauri v2 + Rust + SeaORM/SQLite), full-stack flows, and build/release work. Use when the user mentions hark or Hark or requests changes in this repository; after triggering, ask which scope (frontend/backend/fullstack/build-release) to enable."
---

# Hark Skill

## Overview

Enable consistent changes across the Hark frontend, backend, full-stack flows, and build/release tasks with repo-specific conventions and resources.

## Activation Gate

Ask which scope to enable: frontend, backend, fullstack, or build-release.
Confirm platform (desktop or mobile), target area (view/component/store/command), and any constraints before editing.

## Workflow

1. Identify scope and platform.
2. Locate similar code paths and follow existing patterns.
3. Apply changes using repo conventions and available templates.
4. Update related layers (routes, stores, commands) when needed.
5. Propose or run checks/tests only when requested.

## Scope Routing

- Frontend: read `references/frontend.md` and `references/overview.md`; use `assets/templates/view-desktop.vue`, `assets/templates/view-mobile.vue`, `assets/templates/pinia-store.ts` as starters.
- Backend: read `references/backend.md` and `references/overview.md`; use `assets/templates/tauri-command.rs`.
- Fullstack: read `references/fullstack.md` plus frontend/backend references; use `assets/templates/tauri-command.ts`.
- Build/Release: read `references/build-release.md` and `references/checklists.md`.

## Scripts

Use `scripts/hark_summary.py` for quick repo context (views/stores counts and paths).
Use `scripts/hark_tauri_map.py` to list Tauri commands and frontend invoke usage.

## References

Use `references/overview.md` for stack, directories, aliases, and global conventions.
Use `references/checklists.md` for per-scope checklists.