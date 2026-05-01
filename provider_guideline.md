# Provider Guideline - Crafty Bay

This document defines the standard pattern for creating `Provider` classes in the Crafty Bay project to ensure consistency, scalability, and clean code.

## 1. Class Structure
Every Provider must extend `ChangeNotifier`.

```dart
class FeatureNameProvider extends ChangeNotifier {
  // 1. Private State Variables
  // 2. Public Getters
  // 3. API/Logic Methods
}
```

## 2. State Management Rules
- **Loading State:** Always use a private boolean variable (e.g., `_inProgress`) to track API calls.
- **Error Handling:** Use a nullable String `_errorMessage` to store API error messages.
- **Data Storage:** Use private variables for data models and provide public getters.

## 3. Pagination Pattern (Advanced)
For lists requiring pagination (like Product List or Wishlist), follow this state structure:

```dart
  final int _pageSize = 20;
  int _currentPage = 0;
  int? _lastPage;

  bool _getInitialDataInProgress = false;
  bool _getMoreDataInProgress = false;

  List<DataModel> _items = [];
  
  bool get isInitialLoading => _currentPage == 1;
  bool get isLoading => _getInitialDataInProgress || _getMoreDataInProgress;
```

**Pagination Method Logic:**
1. Increment `_currentPage`.
2. Check if `_lastPage` is reached.
3. Use separate flags for `initialLoading` (first page) and `moreDataLoading` (subsequent pages).
4. If the API fails, decrement `_currentPage` to allow retry.

## 4. Single Item Loading (Tracking List)
To show loaders on specific items (e.g., Add to Wishlist button on a Card) without reloading the whole list:
- Use a `List<String> loadingItemIds = []`.
- Add ID to the list when the operation starts, remove when it ends.
- Provide a helper method: `bool isProcessing(String id) => loadingItemIds.contains(id);`.

## 5. UI Implementation Rules
- **Initial Fetch:** Use `WidgetsBinding.instance.addPostFrameCallback` in `initState`.
- **Infinite Scroll:** Use `ScrollController` with a listener checking `extentAfter < 300` to trigger the next page.
- **Cleanup:** Always `dispose()` controllers to avoid memory leaks.
- **Local Providers:** For screens where data doesn't need to persist globally (e.g., Product Details, Wishlist), create a local instance and use `ChangeNotifierProvider.value`.

## 6. Naming Conventions
- Loading variable: `_getXInProgress` (getter: `getXInProgress`)
- Error variable: `_errorMessage` (getter: `errorMessage`)
- API Method: `getProductName()`, `addToCart()`, etc.

## 7. Null Safety & Models
- Always prioritize Null Safety.
- Avoid `late` variables for API data; use nullable types and handle them in the UI.
- Use `Model.fromJson()` for data parsing.
