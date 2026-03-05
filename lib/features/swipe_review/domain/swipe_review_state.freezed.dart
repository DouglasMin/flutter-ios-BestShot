// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'swipe_review_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SwipeDecision {

 String get assetId; bool get kept;
/// Create a copy of SwipeDecision
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SwipeDecisionCopyWith<SwipeDecision> get copyWith => _$SwipeDecisionCopyWithImpl<SwipeDecision>(this as SwipeDecision, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SwipeDecision&&(identical(other.assetId, assetId) || other.assetId == assetId)&&(identical(other.kept, kept) || other.kept == kept));
}


@override
int get hashCode => Object.hash(runtimeType,assetId,kept);

@override
String toString() {
  return 'SwipeDecision(assetId: $assetId, kept: $kept)';
}


}

/// @nodoc
abstract mixin class $SwipeDecisionCopyWith<$Res>  {
  factory $SwipeDecisionCopyWith(SwipeDecision value, $Res Function(SwipeDecision) _then) = _$SwipeDecisionCopyWithImpl;
@useResult
$Res call({
 String assetId, bool kept
});




}
/// @nodoc
class _$SwipeDecisionCopyWithImpl<$Res>
    implements $SwipeDecisionCopyWith<$Res> {
  _$SwipeDecisionCopyWithImpl(this._self, this._then);

  final SwipeDecision _self;
  final $Res Function(SwipeDecision) _then;

/// Create a copy of SwipeDecision
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? assetId = null,Object? kept = null,}) {
  return _then(_self.copyWith(
assetId: null == assetId ? _self.assetId : assetId // ignore: cast_nullable_to_non_nullable
as String,kept: null == kept ? _self.kept : kept // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SwipeDecision].
extension SwipeDecisionPatterns on SwipeDecision {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SwipeDecision value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SwipeDecision() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SwipeDecision value)  $default,){
final _that = this;
switch (_that) {
case _SwipeDecision():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SwipeDecision value)?  $default,){
final _that = this;
switch (_that) {
case _SwipeDecision() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String assetId,  bool kept)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SwipeDecision() when $default != null:
return $default(_that.assetId,_that.kept);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String assetId,  bool kept)  $default,) {final _that = this;
switch (_that) {
case _SwipeDecision():
return $default(_that.assetId,_that.kept);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String assetId,  bool kept)?  $default,) {final _that = this;
switch (_that) {
case _SwipeDecision() when $default != null:
return $default(_that.assetId,_that.kept);case _:
  return null;

}
}

}

/// @nodoc


class _SwipeDecision implements SwipeDecision {
  const _SwipeDecision({required this.assetId, required this.kept});
  

@override final  String assetId;
@override final  bool kept;

/// Create a copy of SwipeDecision
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SwipeDecisionCopyWith<_SwipeDecision> get copyWith => __$SwipeDecisionCopyWithImpl<_SwipeDecision>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SwipeDecision&&(identical(other.assetId, assetId) || other.assetId == assetId)&&(identical(other.kept, kept) || other.kept == kept));
}


@override
int get hashCode => Object.hash(runtimeType,assetId,kept);

@override
String toString() {
  return 'SwipeDecision(assetId: $assetId, kept: $kept)';
}


}

/// @nodoc
abstract mixin class _$SwipeDecisionCopyWith<$Res> implements $SwipeDecisionCopyWith<$Res> {
  factory _$SwipeDecisionCopyWith(_SwipeDecision value, $Res Function(_SwipeDecision) _then) = __$SwipeDecisionCopyWithImpl;
@override @useResult
$Res call({
 String assetId, bool kept
});




}
/// @nodoc
class __$SwipeDecisionCopyWithImpl<$Res>
    implements _$SwipeDecisionCopyWith<$Res> {
  __$SwipeDecisionCopyWithImpl(this._self, this._then);

  final _SwipeDecision _self;
  final $Res Function(_SwipeDecision) _then;

/// Create a copy of SwipeDecision
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? assetId = null,Object? kept = null,}) {
  return _then(_SwipeDecision(
assetId: null == assetId ? _self.assetId : assetId // ignore: cast_nullable_to_non_nullable
as String,kept: null == kept ? _self.kept : kept // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$SwipeReviewState {

 bool get initialized; List<SelectedPhoto> get assets; int get currentIndex; List<String> get keptIds; List<SwipeDecision> get history;
/// Create a copy of SwipeReviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SwipeReviewStateCopyWith<SwipeReviewState> get copyWith => _$SwipeReviewStateCopyWithImpl<SwipeReviewState>(this as SwipeReviewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SwipeReviewState&&(identical(other.initialized, initialized) || other.initialized == initialized)&&const DeepCollectionEquality().equals(other.assets, assets)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&const DeepCollectionEquality().equals(other.keptIds, keptIds)&&const DeepCollectionEquality().equals(other.history, history));
}


@override
int get hashCode => Object.hash(runtimeType,initialized,const DeepCollectionEquality().hash(assets),currentIndex,const DeepCollectionEquality().hash(keptIds),const DeepCollectionEquality().hash(history));

@override
String toString() {
  return 'SwipeReviewState(initialized: $initialized, assets: $assets, currentIndex: $currentIndex, keptIds: $keptIds, history: $history)';
}


}

/// @nodoc
abstract mixin class $SwipeReviewStateCopyWith<$Res>  {
  factory $SwipeReviewStateCopyWith(SwipeReviewState value, $Res Function(SwipeReviewState) _then) = _$SwipeReviewStateCopyWithImpl;
@useResult
$Res call({
 bool initialized, List<SelectedPhoto> assets, int currentIndex, List<String> keptIds, List<SwipeDecision> history
});




}
/// @nodoc
class _$SwipeReviewStateCopyWithImpl<$Res>
    implements $SwipeReviewStateCopyWith<$Res> {
  _$SwipeReviewStateCopyWithImpl(this._self, this._then);

  final SwipeReviewState _self;
  final $Res Function(SwipeReviewState) _then;

/// Create a copy of SwipeReviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? initialized = null,Object? assets = null,Object? currentIndex = null,Object? keptIds = null,Object? history = null,}) {
  return _then(_self.copyWith(
initialized: null == initialized ? _self.initialized : initialized // ignore: cast_nullable_to_non_nullable
as bool,assets: null == assets ? _self.assets : assets // ignore: cast_nullable_to_non_nullable
as List<SelectedPhoto>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,keptIds: null == keptIds ? _self.keptIds : keptIds // ignore: cast_nullable_to_non_nullable
as List<String>,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<SwipeDecision>,
  ));
}

}


/// Adds pattern-matching-related methods to [SwipeReviewState].
extension SwipeReviewStatePatterns on SwipeReviewState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SwipeReviewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SwipeReviewState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SwipeReviewState value)  $default,){
final _that = this;
switch (_that) {
case _SwipeReviewState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SwipeReviewState value)?  $default,){
final _that = this;
switch (_that) {
case _SwipeReviewState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool initialized,  List<SelectedPhoto> assets,  int currentIndex,  List<String> keptIds,  List<SwipeDecision> history)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SwipeReviewState() when $default != null:
return $default(_that.initialized,_that.assets,_that.currentIndex,_that.keptIds,_that.history);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool initialized,  List<SelectedPhoto> assets,  int currentIndex,  List<String> keptIds,  List<SwipeDecision> history)  $default,) {final _that = this;
switch (_that) {
case _SwipeReviewState():
return $default(_that.initialized,_that.assets,_that.currentIndex,_that.keptIds,_that.history);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool initialized,  List<SelectedPhoto> assets,  int currentIndex,  List<String> keptIds,  List<SwipeDecision> history)?  $default,) {final _that = this;
switch (_that) {
case _SwipeReviewState() when $default != null:
return $default(_that.initialized,_that.assets,_that.currentIndex,_that.keptIds,_that.history);case _:
  return null;

}
}

}

/// @nodoc


class _SwipeReviewState extends SwipeReviewState {
  const _SwipeReviewState({this.initialized = false, final  List<SelectedPhoto> assets = const <SelectedPhoto>[], this.currentIndex = 0, final  List<String> keptIds = const <String>[], final  List<SwipeDecision> history = const <SwipeDecision>[]}): _assets = assets,_keptIds = keptIds,_history = history,super._();
  

@override@JsonKey() final  bool initialized;
 final  List<SelectedPhoto> _assets;
@override@JsonKey() List<SelectedPhoto> get assets {
  if (_assets is EqualUnmodifiableListView) return _assets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assets);
}

@override@JsonKey() final  int currentIndex;
 final  List<String> _keptIds;
@override@JsonKey() List<String> get keptIds {
  if (_keptIds is EqualUnmodifiableListView) return _keptIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_keptIds);
}

 final  List<SwipeDecision> _history;
@override@JsonKey() List<SwipeDecision> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}


/// Create a copy of SwipeReviewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SwipeReviewStateCopyWith<_SwipeReviewState> get copyWith => __$SwipeReviewStateCopyWithImpl<_SwipeReviewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SwipeReviewState&&(identical(other.initialized, initialized) || other.initialized == initialized)&&const DeepCollectionEquality().equals(other._assets, _assets)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&const DeepCollectionEquality().equals(other._keptIds, _keptIds)&&const DeepCollectionEquality().equals(other._history, _history));
}


@override
int get hashCode => Object.hash(runtimeType,initialized,const DeepCollectionEquality().hash(_assets),currentIndex,const DeepCollectionEquality().hash(_keptIds),const DeepCollectionEquality().hash(_history));

@override
String toString() {
  return 'SwipeReviewState(initialized: $initialized, assets: $assets, currentIndex: $currentIndex, keptIds: $keptIds, history: $history)';
}


}

/// @nodoc
abstract mixin class _$SwipeReviewStateCopyWith<$Res> implements $SwipeReviewStateCopyWith<$Res> {
  factory _$SwipeReviewStateCopyWith(_SwipeReviewState value, $Res Function(_SwipeReviewState) _then) = __$SwipeReviewStateCopyWithImpl;
@override @useResult
$Res call({
 bool initialized, List<SelectedPhoto> assets, int currentIndex, List<String> keptIds, List<SwipeDecision> history
});




}
/// @nodoc
class __$SwipeReviewStateCopyWithImpl<$Res>
    implements _$SwipeReviewStateCopyWith<$Res> {
  __$SwipeReviewStateCopyWithImpl(this._self, this._then);

  final _SwipeReviewState _self;
  final $Res Function(_SwipeReviewState) _then;

/// Create a copy of SwipeReviewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? initialized = null,Object? assets = null,Object? currentIndex = null,Object? keptIds = null,Object? history = null,}) {
  return _then(_SwipeReviewState(
initialized: null == initialized ? _self.initialized : initialized // ignore: cast_nullable_to_non_nullable
as bool,assets: null == assets ? _self._assets : assets // ignore: cast_nullable_to_non_nullable
as List<SelectedPhoto>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,keptIds: null == keptIds ? _self._keptIds : keptIds // ignore: cast_nullable_to_non_nullable
as List<String>,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<SwipeDecision>,
  ));
}


}

// dart format on
