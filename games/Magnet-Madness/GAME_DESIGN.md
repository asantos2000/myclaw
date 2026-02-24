# Magnet Madness - Game Design Document

## Core Concept
A horror-comedy puzzle game where the player, as an invisible experiment designer, sets up magnetic obstacle courses for a glitch-prone robot assistant named Bleep. The player manipulates the environment and chooses Bleep's material, then watches autonomously as Bleep attempts to navigate the course (~30 seconds). A reactive scientist portrait provides humorous commentary during execution, and the player has one emergency stop per run to abort and prevent damage.

## Tone & Atmosphere
- **Primary:** Comedy derived from slapstick, Bleep's glitchy antics, and the scientist's over-the-top reactions
- **Secondary:** Light horror in the facility's aesthetic (creepy corridors, ominous machinery) but played for laughs
- **Inspiration:** Portal's puzzle design + Doom's reactive portrait + WarioWare's rapid failure comedy

## Core Characters

### Dr. [Player Name] (Scientist)
- Never visible in scene; represented by:
  - Reactive portrait overlay (Doom-style) with expressiveness: astonishment, surprise, laughter, covering eyes, embarrassment, pride, horror
  - Commentary voice delivering humorous catchphrases and narration
  - Text boxes during transitions (intro/outro)
- Role: Experiment designer and narrator
- Personality: Eccentric, enthusiastic, prone to melodrama, genuinely cares for Bleep

### Bleep (Robot Assistant)
- Small, dome-headed robot with treads (distinct from R2-D2)
- Communicates via beeps, whirs, and occasional broken speech synthesis
- Autonomous during experiment runs (no player control)
- Physical frame is swappable: wood, aluminum, steel, plastic, ruby
- Glitches occur under strong magnetic influence
- Can become damaged on hard failures (visibly unbalanced, creaking, spitting screws)
- Damage persists until repaired between experiments

## Gameplay Loop

1. **Design Phase** (Player controlled)
   - Place magnetic/non-magnetic objects in the course
   - Set Bleep's starting position and material
   - Configure any moving obstacles or magnets
   - Preview magnetic field strength overlay (optional)

2. **Experiment Phase** (Autonomous, ~30s)
   - Click "Start Experiment"
   - Bleep uses pathfinding to navigate to goal
   - Bleep's AI is affected by material properties and glitches
   - Scientist portrait reacts to events (expressions + catchphrases)
   - Player can press **Emergency Stop** button (once per run) to abort and prevent damage

3. **Transition Phase**
   - If success: scientist congratulates (with humor)
   - If failure: scientist reacts to outcome
   - If Bleep damaged: scientist expresses concern/regret
   - Bleep returns to start (visibly damaged if failed without emergency stop)
   - Player may repair Bleep before next attempt

4. **Repeat** with adjusted design

---

## Core Mechanics

### 1. Magnetic Environment Setup
- Player places objects with properties:
  - **Magnetic strength** (Gauss rating)
  - **Polarity** (attract/repel/both)
  - **Weight** (affects force needed to move)
  - **Fixed vs movable**
- Magnetic field visualization (optional): heatmap overlay showing cumulative field strength zones
- Objects can be chained: magnet attracts metal object, which hits switch, etc.

### 2. Bleep Material System
**Materials:**
- **Wood:** -75% magnetic interference, slower movement, lower health
- **Aluminum:** +25% speed, -25% weight (easier to push),中等 susceptibility
- **Steel:** Strongly attracted to magnetic fields (extra pull), faster on metal surfaces, high susceptibility
- **Plastic:** Near immunity to magnetism, higher health, but fragile (takes more collision damage)
- **Ruby (rare):** Reflects certain polarities, enables phasing through weak magnetic barriers

**Material Choice Effects on AI:**
- Affects pathfinding weights (steel: attracted to metal paths; wood: avoids high-Gauss zones)
- Glitch probability and type distribution
- Speed stat
- Collision damage multiplier

### 3. Glitch Mechanics
- Triggered when Bleep passes through high-magnetic zones
- **Severity scales** with cumulative exposure and material susceptibility
- **Glitch types** (each has 2-5s duration, some chain):
  - Inverse controls (moves opposite to intended direction)
  - Hyper-speed (rushes uncontrollably)
  - Magnet lock (attracted to nearest metal object, stuck)
  - Audio glitch (plays loud beeps, static, music)
  - Speech synthesis (random movie quotes, nonsense)
  - Temporary abilities (phase through thin walls, jump higher)
  - Visual hallucination (sees fake paths)
  - System crash (reboot after 3s delay)
  - Spin in circles
  - Emit electromagnetic pulse (disables nearby active traps)

- **Probability model:**
  ```
  base_rate = 0.05 per second
  multiplier = (field_gauss / 10) * material_susceptibility
  glitch_chance = base_rate * (1 + multiplier)
  ```

### 4. Damage & Repair
- Bleep takes damage from:
  - Collisions with hard objects at speed
  - Severe glitches that cause self-inflicted damage
  - Crashing (failing the course with impact)
- Damage manifests as:
  - **Visual:** dents, missing screws, smoking, unbalanced wobble, sparks
  - **Functional:** speed reduction, increased glitch chance, occasional lockups
- **Repair:** Between experiments, player can click "Repair Bleep" (instant, no cost)
- **Emergency Stop:** Single use per run; aborts experiment, Blimp returns safely but experiment fails. Prevents new damage but does not repair existing.

### 5. Scientist Commentary System
- **Portrait overlay** (Doom-style) with ~12 expressive animations
- **Event-triggered phrases** (max 1 every 3–5 seconds to avoid spam)
  - On glitch: "What's happening to my robot?!"
  - On near-miss: "Phew, that was close!"
  - On damage: "That's going to leave a mark!"
  - On success: "Brilliant! Though I may have gotten lucky."
  - On emergency stop: "Good call! He would have been toast."
- **Catchphrases** reference classic mad scientist tropes
- **Tone escalates** with repeated failures (concern → exasperation → despair)

---

## Puzzle Design

### Run Parameters
- Target completion time: 25–35 seconds
- Courses are self-contained "test chambers"
- Must have clear start and goal zones
- Must include at least one magnetic field area strong enough to risk glitches

### Example Puzzles

1. **The Basic Gauntlet**
   - Straight path with metal obstacles to push away
   - Teach attract/repel
   - No glitch zones

2. **Steel Attraction**
   - Goal is across a gap; only steel frame can magnetically swing from metal crane
   - But steel causes glitches in central zone
   - Trade-off: material speed vs stability

3. **Magnetic Maze**
   - Narrow corridor with alternating attract/repel magnets
   - Requires precise control of field exposure
   - Wood frame recommended but moves slowly

4. **Glitch Harnessing**
   - Puzzle requires Bleep to glitch in a specific way (hyper-speed to cross moving platform)
   - Player must set up to trigger desired glitch reliably

5. **Damage Management**
   - Course has unavoidable collision at end; need plastic frame to survive impact
   - But plastic is fragile earlier; must protect with careful object placement

6. **Emergency Stop Training**
   - Teaches timing of kill switch: course has damage-dealing spike trap that can be avoided by stopping before it

7. **Combo Challenge**
   - Must switch materials during course? (Not in prototype; future: scanning stations mid-run)

### Constraints & Scoring
- Primary: Success/failure
- Secondary: Time, damage taken, number of glitches
- Optional: Perfect run (no damage, under 30s, <3 glitches)
- No lives; unlimited retries with repairs

---

## Narrative Structure (Looped)

The facility is already abandoned; the scientist is conducting "experiments" in the empty chambers. The narrative is delivered through:

- **Transition texts:** Each puzzle introduction sets a humorous scenario (e.g., "Test 47: Can Bleep cross the Magnetized Megalodon tank?")
- **Scientist commentary** during runs provides personality
- **Experiment logs** that accumulate with each puzzle (tracking Bleep's incident count, materials used, etc.)
- No traditional cutscenes; story emerges from the absurdity of the experiments and Bleep's suffering

---

## Visual Style

- **Color Palette:** Blues (scientific), warning oranges, eerie purples for magnetic fields
- **Facility Aesthetic:** Clean 80s retro-futurism decaying into haunted industrial
- **Bleep Design:** Cute, expressive through eye/antenna movements, treads, and sparking when damaged
- **Scientist Portrait:** 2D animated illustrations in corner, exaggerated expressions
- **UI:** Laboratory console aesthetic; gauges, switches, scientific notation

---

## Audio Design

- **Bleep sounds:** Beep patterns convey emotion; glitch = distorted music/speech
- **Scientist voice:** Wailing, gasping, triumphant exclamations
- **Magnetic effects:** Low hums, rising tension as field strength increases
- **Music:** Upbeat theremin-laced horror-comedy during runs; suspenseful in design phase
- **Damage sounds:** Crunching metal, sparking, robotic whirs turning to grinding

---

## UI/UX

### Design Phase
- Course editor area with object palette
- Bleep placement tool
- Material selector
- "Start Experiment" button
- Optional: magnetic overlay toggle
- Course stats (estimated difficulty, predicted glitch zones)

### Experiment Phase
- Main view (top 80%)
- Scientist portrait overlay (bottom-right corner)
- **Emergency Stop** button (prominent, red, blinks when Bleep is about to take damage)
- Bleep status (material, health bar, current glitch if any)
- Timer (seconds remaining or elapsed)

### Transition/Results
- Text box with scientist's commentary
- Buttons: "Repair & Retry", "Next Puzzle", "Back to Editor"
- Experiment log summary (time, damage, glitches)
- Achievement popups (if any)

---

## Platform & Scope

- **Target:** PC (mouse-driven)
- **Engine:** Godot 4.x (2D or 2.5D with 3D physics)
- **Estimated Playtime:** 6-8 hours (70-100 puzzles)
- **Replayability:** Multiple material solutions, achievement hunting (glitch-specific challenges, minimal time), user-generated course sharing potential
- **Accessibility:**
  - Colorblind magnetic field modes
  - Reduce glitch intensity slider
  - Bleep's beeps can be subtitled
  - Emergency stop button size adjustable

---

## Similar Games

- **Portal/Portal 2:** Puzzle design, dark humor
- **WarioWare:** Rapid failure states, comedy from chaos
- **Human: Fall Flat:** Physics-based slapstick
- **The Incredible Machine:** Build chain-reaction puzzles
- **Doom (SNES):** Reactive portrait system

---

## Unique Selling Points

1. **"Design then watch"** paradigm: tension between careful planning and unpredictable execution
2. **Emergency stop** adds last-second decision pressure even in hands-off gameplay
3. **Scientist as live narrator** with expressive reactions makes observation entertaining
4. **Glitch-as-mechanic:** Bleep's instability is a core puzzle element, not just flavor
5. **Damage accumulates:** failures have consequences across multiple attempts

---

## Technical Considerations

- **Physics:** Robust 2D physics engine for magnetic forces, collisions, object movement
- **AI:** A* pathfinding with material-modified weights and real-time glitch interruption
- **Glitch system:** Event scheduler with probability queues and effect stacks
- **Damage tracking:** Persistent state per experiment session, visual degradation system
- **Commentary engine:** Event-to-phrase mapping with cooldown and escalation rules
- **Replays:** Record demonstration of physics state changes for debugging/spectator mode

---

## Development Phases

**Phase 1 (Weeks 1-2):** Core physics prototype — magnetism, object movement, Bleep AI without glitches
**Phase 2 (Weeks 3-4):** Glitch system, material properties, damage visuals, scientist portrait (mockup)
**Phase 3 (Week 5):** Emergency stop, commentary system, complete puzzle loop
**Phase 4 (Week 6):** 5-7 hand-crafted puzzles, polish, bug-fixes
**Phase 5+ (if approved):** Content expansion, user course editor, sharing, more materials/glitches

---

**Status:** Concept Phase → Ready for Prototype
**Next Steps:** Build Godot project, implement core magnetic physics and Bleep AI
