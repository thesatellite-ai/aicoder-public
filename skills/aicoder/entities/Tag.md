# Tag

Per-entity reference for the `Tag` GraphQL type. Generated from `modules/apidash/internal/graph/schemas/*.graphql` — regenerate via `task skill:gen`.

## Object type

_Defined in `ent.graphql`._

```graphql
type Tag implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  """
  Display name as the user typed it; lookup is case-insensitive
  """
  name: String!
  """
  Lowercase normalised name; (workspace_id, name_lower) is unique
  """
  nameLower: String!
  """
  Custom hex color (e.g. #7c3aed). NULL → render from hash palette
  """
  color: String
  """
  Entity-type allowlist for the picker UI. Empty/NULL = all types
  """
  appliesTo: [String!]
  createdByUserID: String
  taggables: [Taggable!]
}
```

## Create input

```graphql
input CreateTagInput {
  workspaceID: String
  """
  Display name as the user typed it; lookup is case-insensitive
  """
  name: String!
  """
  Lowercase normalised name; (workspace_id, name_lower) is unique
  """
  nameLower: String!
  """
  Custom hex color (e.g. #7c3aed). NULL → render from hash palette
  """
  color: String
  """
  Entity-type allowlist for the picker UI. Empty/NULL = all types
  """
  appliesTo: [String!]
  createdByUserID: String
  taggableIDs: [ID!]
}
```

## Update input

```graphql
input UpdateTagInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  """
  Display name as the user typed it; lookup is case-insensitive
  """
  name: String
  """
  Lowercase normalised name; (workspace_id, name_lower) is unique
  """
  nameLower: String
  """
  Custom hex color (e.g. #7c3aed). NULL → render from hash palette
  """
  color: String
  clearColor: Boolean
  """
  Entity-type allowlist for the picker UI. Empty/NULL = all types
  """
  appliesTo: [String!]
  appendAppliesTo: [String!]
  clearAppliesTo: Boolean
  createdByUserID: String
  clearCreatedByUserID: Boolean
  addTaggableIDs: [ID!]
  removeTaggableIDs: [ID!]
  clearTaggables: Boolean
}
```

## Where filter (top-level connection)

```graphql
input TagWhereInput {
  not: TagWhereInput
  and: [TagWhereInput!]
  or: [TagWhereInput!]
  """
  id field predicates
  """
  id: ID
  idNEQ: ID
  idIn: [ID!]
  idNotIn: [ID!]
  idGT: ID
  idGTE: ID
  idLT: ID
  idLTE: ID
  idEqualFold: ID
  idContainsFold: ID
  """
  workspace_id field predicates
  """
  workspaceID: String
  workspaceIDNEQ: String
  workspaceIDIn: [String!]
  workspaceIDNotIn: [String!]
  workspaceIDGT: String
  workspaceIDGTE: String
  workspaceIDLT: String
  workspaceIDLTE: String
  workspaceIDContains: String
  workspaceIDHasPrefix: String
  workspaceIDHasSuffix: String
  workspaceIDIsNil: Boolean
  workspaceIDNotNil: Boolean
  workspaceIDEqualFold: String
  workspaceIDContainsFold: String
  """
  created_at field predicates
  """
  createdAt: Time
  createdAtNEQ: Time
  createdAtIn: [Time!]
  createdAtNotIn: [Time!]
  createdAtGT: Time
  createdAtGTE: Time
  createdAtLT: Time
  createdAtLTE: Time
  createdAtIsNil: Boolean
  createdAtNotNil: Boolean
  """
  updated_at field predicates
  """
  updatedAt: Time
  updatedAtNEQ: Time
  updatedAtIn: [Time!]
  updatedAtNotIn: [Time!]
  updatedAtGT: Time
  updatedAtGTE: Time
  updatedAtLT: Time
  updatedAtLTE: Time
  updatedAtIsNil: Boolean
  updatedAtNotNil: Boolean
  """
  name field predicates
  """
  name: String
  nameNEQ: String
  nameIn: [String!]
  nameNotIn: [String!]
  nameGT: String
  nameGTE: String
  nameLT: String
  nameLTE: String
  nameContains: String
  nameHasPrefix: String
  nameHasSuffix: String
  nameEqualFold: String
  nameContainsFold: String
  """
  name_lower field predicates
  """
  nameLower: String
  nameLowerNEQ: String
  nameLowerIn: [String!]
  nameLowerNotIn: [String!]
  nameLowerGT: String
  nameLowerGTE: String
  nameLowerLT: String
  nameLowerLTE: String
  nameLowerContains: String
  nameLowerHasPrefix: String
  nameLowerHasSuffix: String
  nameLowerEqualFold: String
  nameLowerContainsFold: String
  """
  color field predicates
  """
  color: String
  colorNEQ: String
  colorIn: [String!]
  colorNotIn: [String!]
  colorGT: String
  colorGTE: String
  colorLT: String
  colorLTE: String
  colorContains: String
  colorHasPrefix: String
  colorHasSuffix: String
  colorIsNil: Boolean
  colorNotNil: Boolean
  colorEqualFold: String
  colorContainsFold: String
  """
  created_by_user_id field predicates
  """
  createdByUserID: String
  createdByUserIDNEQ: String
  createdByUserIDIn: [String!]
  createdByUserIDNotIn: [String!]
  createdByUserIDGT: String
  createdByUserIDGTE: String
  createdByUserIDLT: String
  createdByUserIDLTE: String
  createdByUserIDContains: String
  createdByUserIDHasPrefix: String
  createdByUserIDHasSuffix: String
  createdByUserIDIsNil: Boolean
  createdByUserIDNotNil: Boolean
  createdByUserIDEqualFold: String
  createdByUserIDContainsFold: String
  """
  taggables edge predicates
  """
  hasTaggables: Boolean
  hasTaggablesWith: [TaggableWhereInput!]
}
```

## Related queries (2)

```graphql
  resolveProjectLists(
    projectID: ID!
    viewerUserID: ID!
    listLimit: Int
    perListLimit: Int
    search: String
    statusIn: [String!]
    priorityIn: [String!]
    """Tag names (case-insensitive) — task must carry EVERY listed tag to
       remain in the result (AND semantics, matches the picker UX)."""
    tagsIn: [String!]
  ): ProjectListsResolution!
  """Resolve a saved view (filter + manual includes − manual excludes) to its
     visible task set. Pagination + filters mirror resolveTaskList."""
  tags(
    """
    Returns the elements in the list that come after the specified cursor.
    """
    after: Cursor
    """
    Returns the first _n_ elements from the list.
    """
    first: Int
    """
    Returns the elements in the list that come before the specified cursor.
    """
    before: Cursor
    """
    Returns the last _n_ elements from the list.
    """
    last: Int
    """
    Ordering options for Tags returned from the connection.
    """
    orderBy: [TagOrder!]
    """
    Filtering options for Tags returned from the connection.
    """
    where: TagWhereInput
  ): TagConnection!
```

## Related mutations (6)

```graphql
  collision-detected — returns an error if another Tag in the workspace
  detachTag(taggableType: TaggableType!, taggableID: ID!, name: String!): Boolean!
  """Create or return a workspace Tag library row. Lookup is case-insensitive
  ensureTag(workspaceID: ID!, name: String!, color: String, appliesTo: [String!]): Tag!
  """Rename / recolor / change applies-to filter. Rename is case-insensitive
  mergeTag(fromID: ID!, intoID: ID!): Tag!
  tag_id matches the source onto the destination, then deletes the source
  Tag. Both must be in the same workspace."""
  updateTag(id: ID!, name: String, color: String, appliesTo: [String!]): Tag!
  """Delete a Tag and every Taggables pointing at it (entcascade,
  transactional)."""
```

---

See also: [`../API.md`](../API.md) for the flat reference · [`../SKILL.md`](../SKILL.md) for the agent operating manual · [`../playbooks/`](../playbooks/) for end-to-end workflows.
