# Magnet Madness - Phase 1 Prototype

**Status:** Core project scaffolded. Ready for editor work.

## Project Setup

1. Open Godot 4.4
2. Import project: `games/Magnet-Madness/`
3. Open `main.tscn` as the main scene

## What's Included (Phase 1 Core)

### Systems
- `GameManager` (autoload): Phase management, experiment timing, emergency stop
- `Bleep` script: Basic AI navigation, material application, glitch placeholders
- `MagneticObject`: Magnetic field sources with polarity and strength
- `MaterialData`: Resource definitions for wood, aluminum, steel, plastic, ruby

### Scenes
- `main.tscn`: Main level with Bleep, Goal, UI (LevelEditor, ExperimentUI)

### Materials
Auto-generated on first run:
- `resources/materials/wood.tres`
- `resources/materials/aluminum.tres`
- `resources/materials/steel.tres`
- `resources/materials/plastic.tres`
- `resources/materials/ruby.tres`

## Next Steps (Phase 1: Weeks 1-2)

1. **Editor polish**:
   - Drag-and-drop object placement in LevelEditor
   - Object palette UI for magnets, obstacles, movable items
   - Magnetic field overlay toggle

2. **Bleep AI**:
   - Implement material-modified pathfinding weights
   - Integrate magnetic field influence on movement (attraction/repulsion)
   - Bounds checking and obstacle avoidance

3. **Physics**:
   - Magnetic force calculations between objects
   - Collision handling for movable magnets
   - Field strength heatmap visualization (optional)

4. **Glitch system foundation**:
   - Complete glitch probability model based on field exposure
   - Implement at least 2-3 glitch types with visual/audio feedback
   - Damage accumulation on hard failures

5. **Test Level**:
   - Build a simple puzzle with 2-3 magnetic objects
   - Verify Bleep can reach goal with basic navigation

## Known Limitations

- Emergency stop functionality stub
- Scientist portrait system not started
- Audio/music not implemented
- AnimationPlayer animations missing
- No damage visuals
- Glitch effects are minimal

## Running

In Godot editor:
1. Set `Main` as main scene (already configured in project.godot)
2. Press F5 or Play button
3. Use LevelEditor to set material, then click "START EXPERIMENT"

## File Structure

```
games/Magnet-Madness/
├── project.godot          # Engine configuration
├── icon.svg               # Project icon
├── .gitignore             # Git ignore
├── README.md              # This file
├── scenes/
│   └── main.tscn          # Main scene
├── scripts/
│   ├── game_manager.gd    # Autoload singleton
│   ├── main.gd            # Level scene logic
│   ├── bleep.gd           # Bleep AI and physics
│   ├── magnetic_object.gd # Magnetic object base
│   ├── material_data.gd   # Material resource class
│   ├── level_editor.gd    # Design phase UI
│   └── experiment_ui.gd   # Experiment phase UI
└── resources/
    └── materials/         # Material .tres files (auto-created)
```
