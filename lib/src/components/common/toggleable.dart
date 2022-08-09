import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Duration of the animation that moves the toggle from one state to another.
const Duration _kToggleDuration = Duration(milliseconds: 200);

// Duration of the fade animation for the reaction when focus and hover occur.
const Duration _kReactionFadeDuration = Duration(milliseconds: 50);

/// A mixin for [StatefulWidget]s that implement material-themed toggleable
/// controls with toggle animations (e.g. [Switch]es, [Checkbox]es, and
/// [Radio]s).
///
/// The mixin implements the logic for toggling the control (e.g. when tapped)
/// and provides a series of animation controllers to transition the control
/// from one state to another. It does not have any opinion about the visual
/// representation of the toggleable widget. The visuals are defined by a
/// [CustomPainter] passed to the [buildToggleable]. [State] objects using this
/// mixin should call that method from their [build] method.
///
/// This mixin is used to implement the material components for [Switch],
/// [Checkbox], and [Radio] controls.
@optionalTypeArgs
mixin TToggleableStateMixin<S extends StatefulWidget> on TickerProviderStateMixin<S> {
  // Duration of the animation that moves the toggle from one state to another.
  Duration get toggleDuration => _kToggleDuration;

  // Duration of the fade animation for the reaction when focus and hover occur.
  Duration get reactionFadeDuration => _kReactionFadeDuration;

  Duration get radialReactionDuration => kRadialReactionDuration;

  /// Used by subclasses to manipulate the visual value of the control.
  ///
  /// Some controls respond to user input by updating their visual value. For
  /// example, the thumb of a switch moves from one position to another when
  /// dragged. These controls manipulate this animation controller to update
  /// their [position] and eventually trigger an [onChanged] callback when the
  /// animation reaches either 0.0 or 1.0.
  AnimationController get positionController => _positionController;
  late AnimationController _positionController;

  /// The visual value of the control.
  ///
  /// When the control is inactive, the [value] is false and this animation has
  /// the value 0.0. When the control is active, the value is either true or
  /// tristate is true and the value is null. When the control is active the
  /// animation has a value of 1.0. When the control is changing from inactive
  /// to active (or vice versa), [value] is the target value and this animation
  /// gradually updates from 0.0 to 1.0 (or vice versa).
  CurvedAnimation get position => _position;
  late CurvedAnimation _position;

  /// Used by subclasses to control the radial reaction animation.
  ///
  /// Some controls have a radial ink reaction to user input. This animation
  /// controller can be used to start or stop these ink reactions.
  ///
  /// To paint the actual radial reaction, [ToggleablePainter.paintRadialReaction]
  /// may be used.
  AnimationController get reactionController => _reactionController;
  late AnimationController _reactionController;

  /// The visual value of the radial reaction animation.
  ///
  /// Some controls have a radial ink reaction to user input. This animation
  /// controls the progress of these ink reactions.
  ///
  /// To paint the actual radial reaction, [ToggleablePainter.paintRadialReaction]
  /// may be used.
  Animation<double> get reaction => _reaction;
  late Animation<double> _reaction;

  /// Controls the radial reaction's opacity animation for hover changes.
  ///
  /// Some controls have a radial ink reaction to pointer hover. This animation
  /// controls these ink reaction fade-ins and
  /// fade-outs.
  ///
  /// To paint the actual radial reaction, [ToggleablePainter.paintRadialReaction]
  /// may be used.
  Animation<double> get reactionHoverFade => _reactionHoverFade;
  late Animation<double> _reactionHoverFade;
  late AnimationController _reactionHoverFadeController;

  /// Controls the radial reaction's opacity animation for focus changes.
  ///
  /// Some controls have a radial ink reaction to focus. This animation
  /// controls these ink reaction fade-ins and fade-outs.
  ///
  /// To paint the actual radial reaction, [ToggleablePainter.paintRadialReaction]
  /// may be used.
  Animation<double> get reactionFocusFade => _reactionFocusFade;
  late Animation<double> _reactionFocusFade;
  late AnimationController _reactionFocusFadeController;

  /// Whether [value] of this control can be changed by user interaction.
  ///
  /// The control is considered interactive if the [onChanged] callback is
  /// non-null. If the callback is null, then the control is disabled, and
  /// non-interactive. A disabled checkbox, for example, is displayed using a
  /// grey color and its value cannot be changed.
  bool get isInteractive => onChanged != null;

  late final Map<Type, Action<Intent>> actionMap = <Type, Action<Intent>>{
    ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: handleTap),
  };

  /// Called when the control changes value.
  ///
  /// If the control is tapped, [onChanged] is called immediately with the new
  /// value.
  ///
  /// The control is considered interactive (see [isInteractive]) if this
  /// callback is non-null. If the callback is null, then the control is
  /// disabled, and non-interactive. A disabled checkbox, for example, is
  /// displayed using a grey color and its value cannot be changed.
  ValueChanged<bool?>? get onChanged;

  /// False if this control is "inactive" (not checked, off, or unselected).
  ///
  /// If value is true then the control "active" (checked, on, or selected). If
  /// tristate is true and value is null, then the control is considered to be
  /// in its third or "indeterminate" state.
  ///
  /// When the value changes, this object starts the [positionController] and
  /// [position] animations to animate the visual appearance of the control to
  /// the new value.
  bool? get value;

  /// If true, [value] can be true, false, or null, otherwise [value] must
  /// be true or false.
  ///
  /// When [tristate] is true and [value] is null, then the control is
  /// considered to be in its third or "indeterminate" state.
  bool get tristate;

  @override
  void initState() {
    super.initState();
    _positionController = AnimationController(
      duration: toggleDuration,
      value: value == false ? 0.0 : 1.0,
      vsync: this,
    );
    _position = CurvedAnimation(
      parent: _positionController,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    );
    _reactionController = AnimationController(
      duration: radialReactionDuration,
      vsync: this,
    );
    _reaction = CurvedAnimation(
      parent: _reactionController,
      curve: Curves.fastOutSlowIn,
    );
    _reactionHoverFadeController = AnimationController(
      duration: reactionFadeDuration,
      value: _hovering || _focused ? 1.0 : 0.0,
      vsync: this,
    );
    _reactionHoverFade = CurvedAnimation(
      parent: _reactionHoverFadeController,
      curve: Curves.fastOutSlowIn,
    );
    _reactionFocusFadeController = AnimationController(
      duration: reactionFadeDuration,
      value: _hovering || _focused ? 1.0 : 0.0,
      vsync: this,
    );
    _reactionFocusFade = CurvedAnimation(
      parent: _reactionFocusFadeController,
      curve: Curves.fastOutSlowIn,
    );
  }

  /// Runs the [position] animation to transition the Toggleable's appearance
  /// to match [value].
  ///
  /// This method must be called whenever [value] changes to ensure that the
  /// visual representation of the Toggleable matches the current [value].
  void animateToValue() {
    if (tristate) {
      if (value == null) {
        _positionController.value = 0.0;
      }
      if (value ?? true) {
        _positionController.forward();
      } else {
        _positionController.reverse();
      }
    } else {
      if (value ?? false) {
        _positionController.forward();
      } else {
        _positionController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _positionController.dispose();
    _reactionController.dispose();
    _reactionHoverFadeController.dispose();
    _reactionFocusFadeController.dispose();
    super.dispose();
  }

  /// The most recent [Offset] at which a pointer touched the Toggleable.
  ///
  /// This is null if currently no pointer is touching the Toggleable or if
  /// [isInteractive] is false.
  Offset? get downPosition => _downPosition;
  Offset? _downPosition;

  @protected
  void handleTapDown(TapDownDetails details) {
    if (isInteractive) {
      setState(() {
        _downPosition = details.localPosition;
      });
      _reactionController.forward();
    }
  }

  @protected
  void handleTap([Intent? _]) {
    if (!isInteractive) {
      return;
    }
    switch (value) {
      case false:
        onChanged!(true);
        break;
      case true:
        onChanged!(tristate ? null : false);
        break;
      case null:
        onChanged!(false);
        break;
    }
    context.findRenderObject()!.sendSemanticsEvent(const TapSemanticEvent());
  }

  @protected
  void handleTapEnd([TapUpDetails? _]) {
    if (_downPosition != null) {
      setState(() {
        _downPosition = null;
      });
    }
    _reactionController.reverse();
  }

  bool get isFocused => _focused;

  bool get isHovered => _hovering;

  bool _focused = false;

  @protected
  void handleFocusHighlightChanged(bool focused) {
    if (focused != _focused) {
      setState(() {
        _focused = focused;
      });
      if (focused) {
        _reactionFocusFadeController.forward();
      } else {
        _reactionFocusFadeController.reverse();
      }
    }
  }

  bool _hovering = false;

  @protected
  void handleHoverChanged(bool hovering) {
    if (hovering != _hovering) {
      setState(() {
        _hovering = hovering;
      });
      if (hovering) {
        _reactionHoverFadeController.forward();
      } else {
        _reactionHoverFadeController.reverse();
      }
    }
  }

  /// Describes the current [MaterialState] of the Toggleable.
  ///
  /// The returned set will include:
  ///
  ///  * [MaterialState.disabled], if [isInteractive] is false
  ///  * [MaterialState.hovered], if a pointer is hovering over the Toggleable
  ///  * [MaterialState.focused], if the Toggleable has input focus
  ///  * [MaterialState.selected], if [value] is true or null
  Set<MaterialState> get states => <MaterialState>{
        if (!isInteractive) MaterialState.disabled,
        if (_hovering) MaterialState.hovered,
        if (_focused) MaterialState.focused,
        if (value ?? true) MaterialState.selected,
      };

  /// Typically wraps a `painter` that draws the actual visuals of the
  /// Toggleable with logic to toggle it.
  ///
  /// Consider providing a subclass of [ToggleablePainter] as a `painter`, which
  /// implements logic to draw a radial ink reaction for this control. The
  /// painter is usually configured with the [reaction], [position],
  /// [reactionHoverFade], and [reactionFocusFade] animation provided by this
  /// mixin. It is expected to draw the visuals of the Toggleable based on the
  /// current value of these animations. The animations are triggered by
  /// this mixin to transition the Toggleable from one state to another.
  ///
  /// This method must be called from the [build] method of the [State] class
  /// that uses this mixin. The returned [Widget] must be returned from the
  /// build method - potentially after wrapping it in other widgets.
  Widget buildToggleable({
    FocusNode? focusNode,
    bool autofocus = false,
    required MaterialStateProperty<MouseCursor> mouseCursor,
    required Size size,
    required CustomPainter painter,
  }) {
    return FocusableActionDetector(
      actions: actionMap,
      focusNode: focusNode,
      autofocus: autofocus,
      enabled: isInteractive,
      onShowFocusHighlight: handleFocusHighlightChanged,
      onShowHoverHighlight: handleHoverChanged,
      mouseCursor: mouseCursor.resolve(states),
      child: GestureDetector(
        excludeFromSemantics: !isInteractive,
        onTapDown: handleTapDown,
        onTap: handleTap,
        onTapUp: handleTapEnd,
        onTapCancel: handleTapEnd,
        child: Semantics(
          enabled: isInteractive,
          child: CustomPaint(
            size: size,
            painter: painter,
          ),
        ),
      ),
    );
  }
}
