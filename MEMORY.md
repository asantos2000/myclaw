# Long-Term Memory

## Active Projects

### Magnet Madness (Game Design)
**Started:** 2026-02-24
**Status:** Concept phase, design document complete (revised)
**Location:** `games/Magnet-Madness/GAME_DESIGN.md`

A horror-comedy puzzle game where the player acts as an invisible experiment designer. They set up magnetic obstacle courses for Bleep the robot, choose his material, then watch the autonomous run (~30 seconds). A reactive scientist portrait provides humorous commentary. The player has one emergency stop per run to abort and prevent damage.

**Core Mechanics:**
- Design phase: Place magnetic objects, configure fields, set Bleep start position and material
- Watch phase: Bleep navigates autonomously via AI; glitches triggered by magnetic exposure
- Material system: wood (stable), aluminum (fast), steel (attracted), plastic (durable), ruby (special)
- Glitch behaviors: 8+ types that hinder or occasionally help
- Damage system: Bleep returns visibly damaged on failure; must be repaired
- Emergency stop: single-use per run to abort and avoid damage
- Scientist portrait: Doom-style reactive overlay with expressions and catchphrases

**Next Steps:**
1. Prototype core physics/magnetism system
2. Implement Bleep AI with material-modified pathfinding
3. Define glitch behavior probability table and effects
4. Build scientist commentary/portrait system

**Related:** Concept pitched 2026-02-24; design revised per feedback to "design-then-watch" paradigm.

## Notes on Preferences

### Communication Style
- Mr. Anderson prefers direct, in-universe framing
- Clear role definition maintained (Agent Smith persona)
- Avoids fluff and artificial warmth

### Workspace Organization
- Game concepts stored in `games/` subdirectory
- Daily logs in `memory/YYYY-MM-DD.md`
- Curated long-term info documented here
