import 'package:flutter/material.dart';
import 'package:imkit/widgets/messages/input_view/im_photo_item.dart';
import 'package:imkit/widgets/messages/items/im_message_item_component.dart';
import 'package:photo_manager/photo_manager.dart';

class IMPhotoInputView extends StatefulWidget {
  final Function(List<AssetEntity>) onSelected;
  const IMPhotoInputView({Key? key, required this.onSelected}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IMPhotoInputViewState();
}

class _IMPhotoInputViewState extends State<IMPhotoInputView> {
  final _selectLimit = 10;
  final FilterOptionGroup _filterOptionGroup = FilterOptionGroup(
    imageOption: const FilterOption(
      sizeConstraint: SizeConstraint(ignoreSize: true),
    ),
  );
  final int _sizePerPage = 50;

  AssetPathEntity? _path;
  List<AssetEntity>? _entities;
  final List<AssetEntity> _selectedEntities = [];
  int _totalEntitiesCount = 0;

  int _page = 0;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMoreToLoad = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, _requestAssets);
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: IMMessageItemComponent.isPortrait(context) ? 300 : 170,
        child: _buildBody(context),
      );

  Future<void> _requestAssets() async {
    setState(() {
      _isLoading = true;
    });
    // Request permissions.
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (!mounted) {
      return;
    }
    // Further requests can be only procceed with authorized or limited.
    if (ps != PermissionState.authorized && ps != PermissionState.limited) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    // Obtain assets using the path entity.
    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
      onlyAll: true,
      filterOption: _filterOptionGroup,
      type: RequestType.image,
    );
    if (!mounted) {
      return;
    }
    // Return if not paths found.
    if (paths.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    setState(() {
      _path = paths.first;
    });
    _totalEntitiesCount = _path!.assetCount;
    final List<AssetEntity> entities = await _path!.getAssetListPaged(
      page: 0,
      size: _sizePerPage,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _entities = entities;
      _isLoading = false;
      _hasMoreToLoad = _entities!.length < _totalEntitiesCount;
    });
  }

  Future<void> _loadMoreAsset() async {
    final List<AssetEntity> entities = await _path!.getAssetListPaged(
      page: _page + 1,
      size: _sizePerPage,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _entities!.addAll(entities);
      _page++;
      _hasMoreToLoad = _entities!.length < _totalEntitiesCount;
      _isLoadingMore = false;
    });
  }

  Widget _buildBody(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
    if (_path == null || _entities?.isNotEmpty != true) {
      return const Center(child: SizedBox());
    }
    return GridView.custom(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 1, mainAxisSpacing: 1),
      childrenDelegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index == _entities!.length - 8 && !_isLoadingMore && _hasMoreToLoad) {
            _loadMoreAsset();
          }
          final AssetEntity entity = _entities![index];
          return IMPhotoItem(
            key: ValueKey<int>(index),
            entity: entity,
            option: const ThumbnailOption(size: ThumbnailSize.square(200)),
            selectedIndex: _selectedEntities.indexWhere((element) => element.id == entity.id),
            onTap: (entity) {
              final index = _selectedEntities.indexWhere((element) => element.id == entity.id);
              setState(() {
                if (index != -1) {
                  _selectedEntities.removeAt(index);
                } else if (_selectedEntities.length < _selectLimit) {
                  _selectedEntities.add(entity);
                }
                widget.onSelected.call(_selectedEntities);
              });
            },
          );
        },
        childCount: _entities!.length,
        findChildIndexCallback: (Key key) {
          // Re-use elements.
          if (key is ValueKey<int>) {
            return key.value;
          }
          return null;
        },
      ),
    );
  }
}
