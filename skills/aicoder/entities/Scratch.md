# Scratch

Per-entity reference for the `Scratch` GraphQL type. Generated from `modules/apidash/internal/graph/schemas/*.graphql` — regenerate via `task skill:gen`.

## Object type

_Defined in `ent.graphql`._

```graphql
type Scratch implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: ID!
  title: String
  body: String
  language: String
  pinned: Boolean!
  position: Float!
  archivedAt: Time
  createdByUserID: String
  project: Project!
}
```

## Create input

```graphql
input CreateScratchInput {
  workspaceID: String
  title: String
  body: String
  language: String
  pinned: Boolean
  position: Float
  archivedAt: Time
  createdByUserID: String
  projectID: ID!
}
```

## Update input

```graphql
input UpdateScratchInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  title: String
  clearTitle: Boolean
  body: String
  clearBody: Boolean
  language: String
  clearLanguage: Boolean
  pinned: Boolean
  position: Float
  archivedAt: Time
  clearArchivedAt: Boolean
  createdByUserID: String
  clearCreatedByUserID: Boolean
  projectID: ID
}
```

## Where filter (top-level connection)

```graphql
input ScratchWhereInput {
  not: ScratchWhereInput
  and: [ScratchWhereInput!]
  or: [ScratchWhereInput!]
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
  projectIDEqualFold: ID
  projectIDContainsFold: ID
  """
  title field predicates
  """
  title: String
  titleNEQ: String
  titleIn: [String!]
  titleNotIn: [String!]
  titleGT: String
  titleGTE: String
  titleLT: String
  titleLTE: String
  titleContains: String
  titleHasPrefix: String
  titleHasSuffix: String
  titleIsNil: Boolean
  titleNotNil: Boolean
  titleEqualFold: String
  titleContainsFold: String
  """
  body field predicates
  """
  body: String
  bodyNEQ: String
  bodyIn: [String!]
  bodyNotIn: [String!]
  bodyGT: String
  bodyGTE: String
  bodyLT: String
  bodyLTE: String
  bodyContains: String
  bodyHasPrefix: String
  bodyHasSuffix: String
  bodyIsNil: Boolean
  bodyNotNil: Boolean
  bodyEqualFold: String
  bodyContainsFold: String
  """
  language field predicates
  """
  language: String
  languageNEQ: String
  languageIn: [String!]
  languageNotIn: [String!]
  languageGT: String
  languageGTE: String
  languageLT: String
  languageLTE: String
  languageContains: String
  languageHasPrefix: String
  languageHasSuffix: String
  languageIsNil: Boolean
  languageNotNil: Boolean
  languageEqualFold: String
  languageContainsFold: String
  """
  pinned field predicates
  """
  pinned: Boolean
  pinnedNEQ: Boolean
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
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
}
```

## Related queries (1)

```graphql
  scratches(
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
    Ordering options for Scratches returned from the connection.
    """
    orderBy: [ScratchOrder!]
    """
    Filtering options for Scratches returned from the connection.
    """
    where: ScratchWhereInput
  ): ScratchConnection!
```

## Related mutations (4)

```graphql
  archiveScratch(id: ID!): Scratch!
  """Reopen a scratch from the trash drawer (clears archivedAt)."""
  createScratch(input: CreateScratchInput!): Scratch!
  """Update a scratch — used for debounced autosave (title/body/language),
     drag-reorder (position) and pin toggling (pinned)."""
  restoreScratch(id: ID!): Scratch!
  """Permanently delete a scratch. Irreversible — the UI only exposes this from
     the trash drawer, behind a confirmation. Returns true on success."""
  updateScratch(id: ID!, input: UpdateScratchInput!): Scratch!
  """Close a scratch tab — soft-archive into the trash drawer. The server
     stamps archivedAt so clients never pass timestamps."""
```

---

See also: [`../API.md`](../API.md) for the flat reference · [`../SKILL.md`](../SKILL.md) for the agent operating manual · [`../playbooks/`](../playbooks/) for end-to-end workflows.
