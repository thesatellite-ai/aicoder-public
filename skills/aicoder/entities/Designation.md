# Designation

Per-entity reference for the `Designation` GraphQL type. Generated from `apidash/internal/graph/schemas/*.graphql` — regenerate via `task skill:gen`.

## Object type

_Defined in `ent.graphql`._

```graphql
type Designation implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  name: String!
  description: String
  color: String
  sortOrder: Int!
  archivedAt: Time
  projectMembers: [ProjectMember!]
}
```

## Create input

```graphql
input CreateDesignationInput {
  workspaceID: String
  name: String!
  description: String
  color: String
  sortOrder: Int
  archivedAt: Time
  projectMemberIDs: [ID!]
}
```

## Update input

```graphql
input UpdateDesignationInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  name: String
  description: String
  clearDescription: Boolean
  color: String
  clearColor: Boolean
  sortOrder: Int
  archivedAt: Time
  clearArchivedAt: Boolean
  addProjectMemberIDs: [ID!]
  removeProjectMemberIDs: [ID!]
  clearProjectMembers: Boolean
}
```

## Where filter (top-level connection)

```graphql
input DesignationWhereInput {
  not: DesignationWhereInput
  and: [DesignationWhereInput!]
  or: [DesignationWhereInput!]
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
  project_members edge predicates
  """
  hasProjectMembers: Boolean
  hasProjectMembersWith: [ProjectMemberWhereInput!]
}
```

## Related queries (1)

```graphql
  designations(
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
    Ordering options for Designations returned from the connection.
    """
    orderBy: [DesignationOrder!]
    """
    Filtering options for Designations returned from the connection.
    """
    where: DesignationWhereInput
  ): DesignationConnection!
```

## Related mutations (2)

```graphql
  createDesignation(input: CreateDesignationInput!): Designation!
  """Update a designation"""
  updateDesignation(id: ID!, input: UpdateDesignationInput!): Designation!
  """Add a member to a project"""
```

---

See also: [`../API.md`](../API.md) for the flat reference · [`../SKILL.md`](../SKILL.md) for the agent operating manual · [`../playbooks/`](../playbooks/) for end-to-end workflows.
