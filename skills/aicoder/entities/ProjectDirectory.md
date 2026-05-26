# ProjectDirectory

Per-entity reference for the `ProjectDirectory` GraphQL type. Generated from `apidash/internal/graph/schemas/*.graphql` — regenerate via `task skill:gen`.

## Object type

_Defined in `ent.graphql`._

```graphql
type ProjectDirectory implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: ID!
  path: String!
  label: String
  isActive: Boolean!
  sortOrder: Int!
  project: Project!
  markdownFiles: [MarkdownFile!]
}
```

## Create input

```graphql
input CreateProjectDirectoryInput {
  workspaceID: String
  path: String!
  label: String
  isActive: Boolean
  sortOrder: Int
  projectID: ID!
  markdownFileIDs: [ID!]
}
```

## Update input

```graphql
input UpdateProjectDirectoryInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  path: String
  label: String
  clearLabel: Boolean
  isActive: Boolean
  sortOrder: Int
  projectID: ID
  addMarkdownFileIDs: [ID!]
  removeMarkdownFileIDs: [ID!]
  clearMarkdownFiles: Boolean
}
```

## Where filter (top-level connection)

```graphql
input ProjectDirectoryWhereInput {
  not: ProjectDirectoryWhereInput
  and: [ProjectDirectoryWhereInput!]
  or: [ProjectDirectoryWhereInput!]
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
  path field predicates
  """
  path: String
  pathNEQ: String
  pathIn: [String!]
  pathNotIn: [String!]
  pathGT: String
  pathGTE: String
  pathLT: String
  pathLTE: String
  pathContains: String
  pathHasPrefix: String
  pathHasSuffix: String
  pathEqualFold: String
  pathContainsFold: String
  """
  label field predicates
  """
  label: String
  labelNEQ: String
  labelIn: [String!]
  labelNotIn: [String!]
  labelGT: String
  labelGTE: String
  labelLT: String
  labelLTE: String
  labelContains: String
  labelHasPrefix: String
  labelHasSuffix: String
  labelIsNil: Boolean
  labelNotNil: Boolean
  labelEqualFold: String
  labelContainsFold: String
  """
  is_active field predicates
  """
  isActive: Boolean
  isActiveNEQ: Boolean
  """
  sort_order field predicates
  """
  sortOrder: Int
  sortOrderNEQ: Int
  sortOrderIn: [Int!]
  sortOrderNotIn: [Int!]
  sortOrderGT: Int
  sortOrderGTE: Int
  sortOrderLT: Int
  sortOrderLTE: Int
  """
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
  """
  markdown_files edge predicates
  """
  hasMarkdownFiles: Boolean
  hasMarkdownFilesWith: [MarkdownFileWhereInput!]
}
```

## Related queries (1)

```graphql
  projectDirectories(
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
    Ordering options for ProjectDirectories returned from the connection.
    """
    orderBy: [ProjectDirectoryOrder!]
    """
    Filtering options for ProjectDirectories returned from the connection.
    """
    where: ProjectDirectoryWhereInput
  ): ProjectDirectoryConnection!
```

## Related mutations (2)

```graphql
  createProjectDirectory(input: CreateProjectDirectoryInput!): ProjectDirectory!
  """Update a project directory"""
  updateProjectDirectory(id: ID!, input: UpdateProjectDirectoryInput!): ProjectDirectory!
  """Delete a project directory"""
```

---

See also: [`../API.md`](../API.md) for the flat reference · [`../SKILL.md`](../SKILL.md) for the agent operating manual · [`../playbooks/`](../playbooks/) for end-to-end workflows.
