# Memory Options

The `memory` parameter in setup_intake takes one of four values:
`none`, `mem0`, `letta`, or `custom`. This document describes each
option, its tradeoffs, and when to pick it.

## none (default)

- **What it is**: stateless. Each session starts fresh.
- **When to use**: first-time users, exploratory sessions, single-turn
  workstreams, demo or evaluation scenarios.
- **Tradeoff**: zero setup cost, zero state to maintain, but the agent
  cannot remember anything across sessions.

Default for v0.1.0.

## mem0

- **What it is**: a memory layer that bolts onto an existing agent
  loop. Framework-agnostic. Compatible with LangChain, CrewAI,
  AutoGen, or custom loops.
- **Source**: github.com/mem0ai/mem0, Apache-2.0.
- **When to use**: the user wants persistent memory across sessions
  but does not want to change agent runtime architecture.
- **Tradeoff**: lightweight, low setup cost, but does not provide
  agent-level memory tiering (Core / Recall / Archival).
- **Compatibility**: works in any host that allows external library
  installation (Claude Code, Codex CLI, Cursor with extensions). Does
  not work in NotebookLM, custom Gem, or custom GPT (those hosts run
  in sandboxed environments without external library install).

## letta

- **What it is**: an agent runtime, not just a memory layer. Wraps
  the agent loop and provides Core, Recall, and Archival memory
  tiers. Letta Code is the official desktop application.
- **Source**: github.com/letta-ai/letta, Apache-2.0.
- **When to use**: the user wants the agent to live inside the memory
  system, with explicit control over which memories are hot, warm,
  and cold.
- **Tradeoff**: more powerful, more setup cost. Requires the user to
  switch agent runtimes.
- **Compatibility**: Letta Code (desktop app) provides the canonical
  runtime. Other CE_RD_OS hosts (Claude Code, Codex CLI) can connect
  to a Letta server via MCP.

## custom

- **What it is**: user-supplied memory implementation, exposed via
  MCP.
- **When to use**: the user has an existing memory system (Zep,
  in-house solution, or specific vector database setup).
- **Tradeoff**: maximum flexibility, maximum setup cost.
- **Compatibility**: works in any host that supports MCP. The user
  is responsible for the MCP server.

## Selection guidance

| If the user wants... | Pick |
|---|---|
| The simplest thing that works | none |
| Persistent memory without changing runtime | mem0 |
| Full agent-level memory tiering | letta |
| To plug in an existing memory system | custom |

## Why Zep, LangGraph checkpointers, and others are NOT in the enum

- **Zep** is a graph-based memory option. It is supported via the
  `custom` slot, not promoted to a top-level enum value, to keep the
  v0.1.0 enum minimal.
- **LangGraph checkpointers** are not memory. They are reliability and
  time-travel debugging primitives. Listed separately in the LangGraph
  ecosystem; not relevant to this enum.

## Citations

- github.com/letta-ai/letta, Apache-2.0.
- letta.com/blog/letta-code, official Letta Code release post,
  December 2025.
- github.com/mem0ai/mem0, Apache-2.0.
- github.com/getzep/zep, Apache-2.0 (mentioned for the custom slot).
- github.com/langchain-ai/langgraph, MIT (mentioned for clarification).

End memory_options.
