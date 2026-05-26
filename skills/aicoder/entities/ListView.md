# ListView

Per-entity reference for the `ListView` GraphQL type. Generated from `apidash/internal/graph/schemas/*.graphql` — regenerate via `task skill:gen`.

## Object type

_Defined in `ent.graphql`._

```graphql
type ListView implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: ID
  ownerUserID: String!
  name: String!
  description: String
  filter: Map
  position: Float!
  pinned: Boolean!
  archivedAt: Time
  isSeeded: Boolean!
  project: Project
  includes: [ListViewInclude!]
  excludes: [ListViewExclude!]
}
```

## Create input

```graphql
input CreateListViewInput {
  workspaceID: String
  ownerUserID: String!
  name: String!
  description: String
  position: Float
  pinned: Boolean
  archivedAt: Time
  isSeeded: Boolean
  projectID: ID
  includeIDs: [ID!]
  excludeIDs: [ID!]
}
```

## Update input

```graphql
input UpdateListViewInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  ownerUserID: String
  name: String
  description: String
  clearDescription: Boolean
  position: Float
  pinned: Boolean
  archivedAt: Time
  clearArchivedAt: Boolean
  isSeeded: Boolean
  projectID: ID
  clearProject: Boolean
  addIncludeIDs: [ID!]
  removeIncludeIDs: [ID!]
  clearIncludes: Boolean
  addExcludeIDs: [ID!]
  removeExcludeIDs: [ID!]
  clearExcludes: Boolean
}
```

## Where filter (top-level connection)

```graphql
input ListViewWhereInput {
  not: ListViewWhereInput
  and: [ListViewWhereInput!]
  or: [ListViewWhereInput!]
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
  project_id field predicates
  """
  projectID: ID
  projectIDNEQ: ID
  projectIDIn: [ID!]
  projectIDNotIn: [ID!]
  projectIDGT: ID
  projectIDGTE: ID
  projectIDLT: ID
  projectIDLTE: ID
  projectIDContains: ID
  projectIDHasPrefix: ID
  projectIDHasSuffix: ID
  projectIDIsNil: Boolean
  projectIDNotNil: Boolean
  projectIDEqualFold: ID
  projectIDContainsFold: ID
  """
  owner_user_id field predicates
  """
  ownerUserID: String
  ownerUserIDNEQ: String
  ownerUserIDIn: [String!]
  ownerUserIDNotIn: [String!]
  ownerUserIDGT: String
  ownerUserIDGTE: String
  ownerUserIDLT: String
  ownerUserIDLTE: String
  ownerUserIDContains: String
  ownerUserIDHasPrefix: String
  ownerUserIDHasSuffix: String
  ownerUserIDEqualFold: String
  ownerUserIDContainsFold: String
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
  description field predicates
  """
  description: String
  descriptionNEQ: String
  descriptionIn: [String!]
  descriptionNotIn: [String!]
  descriptionGT: String
  descriptionGTE: String
  descriptionLT: String
  descriptionLTE: String
  descriptionContains: String
  descriptionHasPrefix: String
  descriptionHasSuffix: String
  descriptionIsNil: Boolean
  descriptionNotNil: Boolean
  descriptionEqualFold: String
  descriptionContainsFold: String
  """
  position field predicates
  """
  position: Float
  positionNEQ: Float
  positionIn: [Float!]
  positionNotIn: [Float!]
  positionGT: Float
  positionGTE: Float
  positionLT: Float
  positionLTE: Float
  """
  pinned field predicates
  """
  pinned: Boolean
  pinnedNEQ: Boolean
  """
  archived_at field predicates
  """
  archivedAt: Time
  archivedAtNEQ: Time
  archivedAtIn: [Time!]
  archivedAtNotIn: [Time!]
  archivedAtGT: Time
  archivedAtGTE: Time
  archivedAtLT: Time
  archivedAtLTE: Time
  archivedAtIsNil: Boolean
  archivedAtNotNil: Boolean
  """
  is_seeded field predicates
  """
  isSeeded: Boolean
  isSeededNEQ: Boolean
  """
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
  """
  includes edge predicates
  """
  hasIncludes: Boolean
  hasIncludesWith: [ListViewIncludeWhereInput!]
  """
  excludes edge predicates
  """
  hasExcludes: Boolean
  hasExcludesWith: [ListViewExcludeWhereInput!]
}
```

## Related queries (1)

```graphql
  listViews(
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
    Ordering options for ListViews returned from the connection.
    """
    orderBy: [ListViewOrder!]
    """
    Filtering options for ListViews returned from the connection.
    """
    where: ListViewWhereInput
  ): ListViewConnection!
```

## Related mutations (3)

```graphql
  archiveListView(id: ID!): ListView!
  """Pin a task to a view so it always appears, even if the filter doesn't match."""
  createListView(input: CreateListViewInput!): ListView!
  """Update a saved view's name / filter / pin / position."""
  updateListView(id: ID!, input: UpdateListViewInput!): ListView!
  """Soft-delete a saved view (sets archived_at)."""
```

---

See also: [`../API.md`](../API.md) for the flat reference · [`../SKILL.md`](../SKILL.md) for the agent operating manual · [`../playbooks/`](../playbooks/) for end-to-end workflows.
