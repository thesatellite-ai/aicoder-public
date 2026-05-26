# MarkdownFile

Per-entity reference for the `MarkdownFile` GraphQL type. Generated from `apidash/internal/graph/schemas/*.graphql` — regenerate via `task skill:gen`.

## Object type

_Defined in `ent.graphql`._

```graphql
type MarkdownFile implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: ID!
  projectDirectoryID: ID!
  relativePath: String!
  name: String!
  extension: String!
  sizeBytes: Int
  modifiedAt: Time
  projectDirectory: ProjectDirectory!
  project: Project!
}
```

## Create input

```graphql
input CreateMarkdownFileInput {
  workspaceID: String
  relativePath: String!
  name: String!
  extension: String!
  sizeBytes: Int
  modifiedAt: Time
  projectDirectoryID: ID!
  projectID: ID!
}
```

## Update input

```graphql
input UpdateMarkdownFileInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  relativePath: String
  name: String
  extension: String
  sizeBytes: Int
  clearSizeBytes: Boolean
  modifiedAt: Time
  clearModifiedAt: Boolean
  projectDirectoryID: ID
  projectID: ID
}
```

## Where filter (top-level connection)

```graphql
input MarkdownFileWhereInput {
  not: MarkdownFileWhereInput
  and: [MarkdownFileWhereInput!]
  or: [MarkdownFileWhereInput!]
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
  project_directory_id field predicates
  """
  projectDirectoryID: ID
  projectDirectoryIDNEQ: ID
  projectDirectoryIDIn: [ID!]
  projectDirectoryIDNotIn: [ID!]
  projectDirectoryIDGT: ID
  projectDirectoryIDGTE: ID
  projectDirectoryIDLT: ID
  projectDirectoryIDLTE: ID
  projectDirectoryIDContains: ID
  projectDirectoryIDHasPrefix: ID
  projectDirectoryIDHasSuffix: ID
  projectDirectoryIDEqualFold: ID
  projectDirectoryIDContainsFold: ID
  """
  relative_path field predicates
  """
  relativePath: String
  relativePathNEQ: String
  relativePathIn: [String!]
  relativePathNotIn: [String!]
  relativePathGT: String
  relativePathGTE: String
  relativePathLT: String
  relativePathLTE: String
  relativePathContains: String
  relativePathHasPrefix: String
  relativePathHasSuffix: String
  relativePathEqualFold: String
  relativePathContainsFold: String
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
  extension field predicates
  """
  extension: String
  extensionNEQ: String
  extensionIn: [String!]
  extensionNotIn: [String!]
  extensionGT: String
  extensionGTE: String
  extensionLT: String
  extensionLTE: String
  extensionContains: String
  extensionHasPrefix: String
  extensionHasSuffix: String
  extensionEqualFold: String
  extensionContainsFold: String
  """
  size_bytes field predicates
  """
  sizeBytes: Int
  sizeBytesNEQ: Int
  sizeBytesIn: [Int!]
  sizeBytesNotIn: [Int!]
  sizeBytesGT: Int
  sizeBytesGTE: Int
  sizeBytesLT: Int
  sizeBytesLTE: Int
  sizeBytesIsNil: Boolean
  sizeBytesNotNil: Boolean
  """
  modified_at field predicates
  """
  modifiedAt: Time
  modifiedAtNEQ: Time
  modifiedAtIn: [Time!]
  modifiedAtNotIn: [Time!]
  modifiedAtGT: Time
  modifiedAtGTE: Time
  modifiedAtLT: Time
  modifiedAtLTE: Time
  modifiedAtIsNil: Boolean
  modifiedAtNotNil: Boolean
  """
  project_directory edge predicates
  """
  hasProjectDirectory: Boolean
  hasProjectDirectoryWith: [ProjectDirectoryWhereInput!]
  """
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
}
```

## Related queries (1)

```graphql
  markdownFiles(
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
    Ordering options for MarkdownFiles returned from the connection.
    """
    orderBy: [MarkdownFileOrder!]
    """
    Filtering options for MarkdownFiles returned from the connection.
    """
    where: MarkdownFileWhereInput
  ): MarkdownFileConnection!
```

---

See also: [`../API.md`](../API.md) for the flat reference · [`../SKILL.md`](../SKILL.md) for the agent operating manual · [`../playbooks/`](../playbooks/) for end-to-end workflows.
