# Echoes of Absence — Design & Competitive Analysis

_Last updated: 2025-02-21_

## Executive Summary

**Echoes of Absence** is a mobile-first puzzle-narrative game where you are a ghost with a 10-second observation window to place "Echoes" — subtle influences in the recent past of NPCs — to prevent your own murder. Set in a 1920s Art Deco mansion, each case is a time-loop murder mystery solved by indirect causality edits.

- **Platform:** Mobile (touch-optimized, portrait)
- **Session length:** 3–8 minutes
- **Core loop:** Observe → Place Echo → See ripple → Gather clues → Repeat until identity of killer is deduced.
- **Aesthetic:** Muted sepia living world; glowing monochrome echo overlay; geometric Art Deco UI; theremin-driven soundscape.
- **Progression:** Unlock new Echo types; monthly case packs; cosmetic customization; daily Cold Case challenges.

## Competitor Mechanic Map

| Game | Adopt | Avoid | Adaptation for Echoes |
|------|------|-------|----------------------|
| **Outer Wilds** | Knowledge persistence across loops; environmental storytelling; non-linear revelation. | Long loops (30–60 min); no direct control; slow pacing. | Journal persists facts across runs; echo changes small elements; short loops. |
| **Return of the Obra Dinn** | Deduction from frozen moments; strong visual language; “one scene one guess”. | Static scene only; 1-bit aesthetic; methodical pacing. | Use “echo vision” to highlight interactive objects; each case is frozen “moment of death” reconstruction with altered clues via echoes. |
| **Her Story** | Database search puzzle; nonlinear fragments; curiosity loops; minimal UI. | Video format heavy; keyword guessing frustration; no consequences. | “Echo Journal” searchable; typeahead keywords unlock abilities/case files; quick queries. |
| **The Forgotten City** | Multi-NPC routines with conditionals; moral branching; knowledge persistence. | Large open sandbox; 20–40 min loops; dialogue heavy. | Smaller focused locations; tight NPC schedules; session-based persistence (within run). |
| **Elsinore** | Influence via prompts/dialogue; relationship changes; time-sensitive decisions. | Extremely slow, text-heavy; long in-game days; Shakespearean language. | “Echo prompt” wheel (tap object to nudge: move, hide, sound); visual ripple effect; concise text. |
| **Deathloop** | Ability unlocks/persistence; combo experimentation; “groundhog day” loop. | FPS on mobile; large map; combat focus. | Unlock echo types; limited ability slots per case; encourage experimentation. |
| **The Stanley Parable** | Short playthroughs; branching outcomes based on small choices; replayability. | Null-game feeling; PC satire. | Multiple endings (killer identity/motive); replay to find alternate solutions or “perfect” run. |
| **Braid** | Time as puzzle; clean visual metaphors; level-based teaching. | Platformer controls on mobile; physics puzzles frustrate casual players. | Optional “rewind last 10 sec” (limited uses per day); progressive mechanic teaching. |
| **Gorogoa** | Visual causality (zoom/frame/connect); elegant tap interactions; artistic puzzles. | No time loop; no narrative branching; limited replayability. | “Echo frame” — tap two objects to create causal link; framing scenes is core interaction. |
| **Monument Valley / Florence / Prune** | Touch-first minimal UI; short emotional sessions; aesthetic cohesion; portrait play. | Linear storytelling; simple interactions; no mystery deduction. | All interactions one-finger; visual cues over text; color shifts for echo overlay; aesthetic-driven.

## Recommended Feature Set

### Core Gameplay
- **Time window:** 10-second observation and placement.
- **Echo types (progressive unlocks):**
  - `Shift` — move a small object.
  - `Whisper` — create a faint sound in a location.
  - `Interfere` — briefly stop an object (door, lever) from working.
  - `Reveal` — show a hidden clue only visible through echo vision.
  - `Chain` — connect two objects so action on one triggers the other.
- **Visualization:** Echo overlay (monochrome glow) + dotted causal lines when placing.
- **Knowledge persistence:** Journal keeps discovered facts, names, locations across runs within a case.

### Narrative & Cases
- **Case structure:** 10–15 min to solve first loop; shorter for subsequent attempts.
- **Multiple endings:** Different killers/motives based on evidence gathered.
- **Monthly packs:** New mansion/case with period-appropriate mystery (e.g., 1920s speakeasy, 1930s ocean liner).
- **Daily Cold Case:** Fixed scenario, leaderboards based on attempts and efficiency.

### Progression & Customization
- **Unlock path:** New echo types, journal themes (Art Deco color schemes), hint systems.
- **Cosmetics:** Echo trail style, journal UI skin, ambient sound themes.
- **Achievements:** “Solve without any failed echoes”, “Find all red herrings”, etc.

### Technical & Mobile UX
- **Orientation:** Portrait-first, scalable to tablet.
- **Controls:** Tap to observe; hold to place echo; two-finger pan/zoom on scene.
- **Performance:** Preload adjacent scenes; cache NPC routines; low battery impact.
- **Accessibility:** Colorblind mode; reduce motion toggle; text size options; haptic feedback toggle.

### Retention & Social
- **Community theories:** In-game forum link or shareable case ID; leaderboards for fastest solves.
- **User-generated cases:** Optional editor for players to craft puzzles (curated, not open).
- **Newsletter/notifications:** New case alerts, community spotlights.

### Monetization Options
- **Option A:** Premium (one-time $3–5). No ads, all cosmetics unlockable via play.
- **Option B:** Free + rewarded ads for hint replays/extra attempts; cosmetic IAP ($0.99–$2.99).
- **Avoid:** Pay-to-win; any mechanic that trivializes deduction.

## Risks & Mitigations

| Risk | Mitigation |
|------|------------|
| 10-second window feels too short or too forgiving | Iterative playtesting; toggle “assist mode” with adjustable window; visual countdown. |
| Causal chains unclear to player | Clear visual ripple preview; echo journal logs cause-effect pairs; hint system shows potential ripple. |
| NPC routines appear random | Ensure schedules are deterministic per case; highlight routines in echo vision; consistent internal logic. |
| Mobile performance with dual layers | Optimize shaders; reduce overdraw; allow quality settings; test on low-end devices. |
| Replayability after case solved | Multiple endings; optional “perfect run” challenges; daily cold cases; community uploads. |
| Art Deco aesthetic may feel dated or niche | Blend with universal ghost story; use color-blind palette; provide alternative themes. |

## Metroidbrainia Alignment

Drawing from Joseph Mansfield’s in-depth article on Metroidbrainia (Thinky Games, July 2025), *Echoes of Absence* aligns strongly with the knowledge-gated exploration genre. Below we map the core pillars of Metroidbrainia design to our concept, highlight unique contributions, and note any deviations.

### Knowledge

Metroidbrainias define themselves by knowledge that unlocks further exploration. In *Echoes*, the core knowledge is **systemic**: understanding how NPC routines work, how echo placements ripple forward, and how to deduce the killer from causal chains. Players also accumulate **non-systemic** knowledge (trivia) — specific times, locations, relationships, and red herrings — that must be pieced together.

- **Systemic knowledge:** NPC behavior rules, echo effect constraints (e.g., cannot affect someone directly observing you), time windows, routine determinism. Gained through rule-discovery during repeated loops.
- **Non-systemic knowledge:** Facts like “the butler carries the poisoned vial at 21:00” or “the victim was seen arguing with the maid”. These are scattered clues that require integration.
- **Knowledge transformation:** Players must synthesize both types to form a complete hypothesis. For example, knowing the butler’s schedule (systemic) plus the time of death (clue) lets you place an echo to intercept the poison.

### Knowledge Gates

Gates in *Echoes* are the mechanisms that verify the player’s understanding before allowing progress toward solving the case. They are primarily **puzzle gates** and **environmental gates**, with some **combination locks**.

- **Puzzle gates:** The final deduction interface where you select the killer and motive. Solving it requires applying all gathered knowledge.
- **Environmental gates:** Certain areas or crucial moments are only accessible if you’ve gained specific knowledge. For example, to observe a private conversation, you must know which room the characters will enter and when; that knowledge gate is opened by discovering the routine.
- **Combination locks:** In some cases, you might need to input a sequence of actions (e.g., echo on object A at time T, then object B) to reveal a hidden clue. These act as combination locks of behavior.
- **Gate clarity:** Gates range from **clear** (you see a locked door and know it needs a key item you lack) to **cryptic** (a strange pattern only understood after many loops) to **hidden** (you didn’t realize certain NPC interactions were gates until later). *Echoes* will feature mostly clear and cryptic gates, with occasional hidden ones for “aha” moments.
- **Transformation requirement:** Unlike simple 1‑to‑1 check gates, many *Echoes* gates expect you to transform knowledge (e.g., combine two separate routine discoveries to infer a missing alibi).

### Non‑Linear Exploration

The mansion is a non‑linear space with branching paths and multiple observation points. Players choose which rooms to monitor, which NPCs to follow, and which echoes to place. Knowledge persistence (the journal) allows revisiting earlier areas with new insights, uncovering previously missed interactions. The 10‑second window encourages precise scouting, but exploration is not forced linear; you can jump between locations across different loops.

### Unique Twists

- **Time‑loop integration:** Knowledge is not just collected; it is *tested* by placing echoes and seeing immediate causal ripples. The loop itself reinforces learning.
- **Indirect influence:** Unlike most Metroidbrainias where you directly manipulate puzzles, *Echoes* uses indirect nudges. The gate is not “solve the puzzle” but “figure out which nudge will alter the outcome.”
- **Murder mystery framing:** The ultimate knowledge gate is identifying the killer. This narrative drive gives purpose to exploration beyond abstract puzzle solving.

### Alignment Summary

*Echoes of Absence* captures the essence of Metroidbrainia: knowledge‑gated exploration, systemic rule‑discovery, non‑linear world traversal, and transformative “aha” moments. It extends the genre with temporal causality and a strong narrative core, positioning it alongside titles like *Outer Wilds*, *The Witness*, and *Toki Tori 2+* while carving its own niche.

## Next Steps (Prioritized)

1. **Prototype core loop:** Tap to observe, place echo, see immediate ripple, read short outcome. Validate fun.
2. **Build one full case:** 3–5 NPCs, one killer, 2–3 echo types, 10–15 min solve time. Playtest with strangers.
3. **Polish visual overlay:** Ghostly monochrome vs. sepia world; ensure clarity on small screens.
4. **Add journal and hint systems:** Keep players from getting stuck >5 min.
5. **Design 2–3 additional cases** to test variety and progression pacing.
6. **Monetization decision** (premium vs free) based on prototype engagement metrics.
7. **Art Deco asset creation** or use of style‑templates (consider hiring illustrator for key scenes).
8. **Launch soft** on TestFlight/Play Console internal; iterate on feedback.

---

*Document version: 2.0* (Metroidbrainia Alignment added)