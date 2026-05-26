# Source

Per-entity reference for the `Source` GraphQL type. Generated from `apidash/internal/graph/schemas/*.graphql` — regenerate via `task skill:gen`.

## Object type

_Defined in `ent.graphql`._

```graphql
type Source implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: ID!
  areaID: ID
  kind: SourceKind!
  bodyFormat: SourceBodyFormat!
  title: String!
  summary: String
  body: String
  externalURL: String
  fileID: String
  mime: String
  tags: [String!]
  capturedByUserID: String
  capturedByAgentID: String
  archivedAt: Time
  project: Project!
  area: Area
}
```

## Create input

```graphql
input CreateSourceInput {
  workspaceID: String
  kind: SourceKind
  bodyFormat: SourceBodyFormat
  title: String!
  summary: String
  body: String
  externalURL: String
  fileID: String
  mime: String
  tags: [String!]
  capturedByUserID: String
  capturedByAgentID: String
  archivedAt: Time
  projectID: ID!
  areaID: ID
}
```

## Update input

```graphql
input UpdateSourceInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  kind: SourceKind
  bodyFormat: SourceBodyFormat
  title: String
  summary: String
  clearSummary: Boolean
  body: String
  clearBody: Boolean
  externalURL: String
  clearExternalURL: Boolean
  fileID: String
  clearFileID: Boolean
  mime: String
  clearMime: Boolean
  tags: [String!]
  appendTags: [String!]
  clearTags: Boolean
  capturedByUserID: String
  clearCapturedByUserID: Boolean
  capturedByAgentID: String
  clearCapturedByAgentID: Boolean
  archivedAt: Time
  clearArchivedAt: Boolean
  projectID: ID
  areaID: ID
  clearArea: Boolean
}
```

## Where filter (top-level connection)

```graphql
input SourceWhereInput {
  not: SourceWhereInput
  and: [SourceWhereInput!]
  or: [SourceWhereInput!]
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
  area_id field predicates
  """
  areaID: ID
  areaIDNEQ: ID
  areaIDIn: [ID!]
  areaIDNotIn: [ID!]
  areaIDGT: ID
  areaIDGTE: ID
  areaIDLT: ID
  areaIDLTE: ID
  areaIDContains: ID
  areaIDHasPrefix: ID
  areaIDHasSuffix: ID
  areaIDIsNil: Boolean
  areaIDNotNil: Boolean
  areaIDEqualFold: ID
  areaIDContainsFold: ID
  """
  kind field predicates
  """
  kind: SourceKind
  kindNEQ: SourceKind
  kindIn: [SourceKind!]
  kindNotIn: [SourceKind!]
  """
  body_format field predicates
  """
  bodyFormat: SourceBodyFormat
  bodyFormatNEQ: SourceBodyFormat
  bodyFormatIn: [SourceBodyFormat!]
  bodyFormatNotIn: [SourceBodyFormat!]
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
  titleEqualFold: String
  titleContainsFold: String
  """
  summary field predicates
  """
  summary: String
  summaryNEQ: String
  summaryIn: [String!]
  summaryNotIn: [String!]
  summaryGT: String
  summaryGTE: String
  summaryLT: String
  summaryLTE: String
  summaryContains: String
  summaryHasPrefix: String
  summaryHasSuffix: String
  summaryIsNil: Boolean
  summaryNotNil: Boolean
  summaryEqualFold: String
  summaryContainsFold: String
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
  external_url field predicates
  """
  externalURL: String
  externalURLNEQ: String
  externalURLIn: [String!]
  externalURLNotIn: [String!]
  externalURLGT: String
  externalURLGTE: String
  externalURLLT: String
  externalURLLTE: String
  externalURLContains: String
  externalURLHasPrefix: String
  externalURLHasSuffix: String
  externalURLIsNil: Boolean
  externalURLNotNil: Boolean
  externalURLEqualFold: String
  externalURLContainsFold: String
  """
  file_id field predicates
  """
  fileID: String
  fileIDNEQ: String
  fileIDIn: [String!]
  fileIDNotIn: [String!]
  fileIDGT: String
  fileIDGTE: String
  fileIDLT: String
  fileIDLTE: String
  fileIDContains: String
  fileIDHasPrefix: String
  fileIDHasSuffix: String
  fileIDIsNil: Boolean
  fileIDNotNil: Boolean
  fileIDEqualFold: String
  fileIDContainsFold: String
  """
  mime field predicates
  """
  mime: String
  mimeNEQ: String
  mimeIn: [String!]
  mimeNotIn: [String!]
  mimeGT: String
  mimeGTE: String
  mimeLT: String
  mimeLTE: String
  mimeContains: String
  mimeHasPrefix: String
  mimeHasSuffix: String
  mimeIsNil: Boolean
  mimeNotNil: Boolean
  mimeEqualFold: String
  mimeContainsFold: String
  """
  captured_by_user_id field predicates
  """
  capturedByUserID: String
  capturedByUserIDNEQ: String
  capturedByUserIDIn: [String!]
  capturedByUserIDNotIn: [String!]
  capturedByUserIDGT: String
  capturedByUserIDGTE: String
  capturedByUserIDLT: String
  capturedByUserIDLTE: String
  capturedByUserIDContains: String
  capturedByUserIDHasPrefix: String
  capturedByUserIDHasSuffix: String
  capturedByUserIDIsNil: Boolean
  capturedByUserIDNotNil: Boolean
  capturedByUserIDEqualFold: String
  capturedByUserIDContainsFold: String
  """
  captured_by_agent_id field predicates
  """
  capturedByAgentID: String
  capturedByAgentIDNEQ: String
  capturedByAgentIDIn: [String!]
  capturedByAgentIDNotIn: [String!]
  capturedByAgentIDGT: String
  capturedByAgentIDGTE: String
  capturedByAgentIDLT: String
  capturedByAgentIDLTE: String
  capturedByAgentIDContains: String
  capturedByAgentIDHasPrefix: String
  capturedByAgentIDHasSuffix: String
  capturedByAgentIDIsNil: Boolean
  capturedByAgentIDNotNil: Boolean
  capturedByAgentIDEqualFold: String
  capturedByAgentIDContainsFold: String
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
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
  """
  area edge predicates
  """
  hasArea: Boolean
  hasAreaWith: [AreaWhereInput!]
}
```

## Related queries (1)

```graphql
  sources(
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
    Ordering options for Sources returned from the connection.
    """
    orderBy: [SourceOrder!]
    """
    Filtering options for Sources returned from the connection.
    """
    where: SourceWhereInput
  ): SourceConnection!
```

## Related mutations (4)

```graphql
  archiveSource(id: ID!): Source!
  createSource(input: CreateSourceInput!): Source!
  unarchiveSource(id: ID!): Source!
  updateSource(id: ID!, input: UpdateSourceInput!): Source!
```

---

See also: [`../API.md`](../API.md) for the flat reference · [`../SKILL.md`](../SKILL.md) for the agent operating manual · [`../playbooks/`](../playbooks/) for end-to-end workflows.
