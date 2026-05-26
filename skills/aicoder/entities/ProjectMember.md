# ProjectMember

Per-entity reference for the `ProjectMember` GraphQL type. Generated from `apidash/internal/graph/schemas/*.graphql` — regenerate via `task skill:gen`.

## Object type

_Defined in `ent.graphql`._

```graphql
type ProjectMember implements Node {
  id: ID!
  createdAt: Time
  updatedAt: Time
  projectID: ID!
  userID: ID!
  designationID: ID!
  joinedAt: Time!
  removedAt: Time
  note: String
  project: Project!
  user: User!
  designation: Designation!
}
```

## Create input

```graphql
input CreateProjectMemberInput {
  joinedAt: Time!
  removedAt: Time
  note: String
  projectID: ID!
  userID: ID!
  designationID: ID!
}
```

## Update input

```graphql
input UpdateProjectMemberInput {
  joinedAt: Time
  removedAt: Time
  clearRemovedAt: Boolean
  note: String
  clearNote: Boolean
  projectID: ID
  userID: ID
  designationID: ID
}
```

## Where filter (top-level connection)

```graphql
input ProjectMemberWhereInput {
  not: ProjectMemberWhereInput
  and: [ProjectMemberWhereInput!]
  or: [ProjectMemberWhereInput!]
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
  user_id field predicates
  """
  userID: ID
  userIDNEQ: ID
  userIDIn: [ID!]
  userIDNotIn: [ID!]
  userIDGT: ID
  userIDGTE: ID
  userIDLT: ID
  userIDLTE: ID
  userIDContains: ID
  userIDHasPrefix: ID
  userIDHasSuffix: ID
  userIDEqualFold: ID
  userIDContainsFold: ID
  """
  designation_id field predicates
  """
  designationID: ID
  designationIDNEQ: ID
  designationIDIn: [ID!]
  designationIDNotIn: [ID!]
  designationIDGT: ID
  designationIDGTE: ID
  designationIDLT: ID
  designationIDLTE: ID
  designationIDContains: ID
  designationIDHasPrefix: ID
  designationIDHasSuffix: ID
  designationIDEqualFold: ID
  designationIDContainsFold: ID
  """
  joined_at field predicates
  """
  joinedAt: Time
  joinedAtNEQ: Time
  joinedAtIn: [Time!]
  joinedAtNotIn: [Time!]
  joinedAtGT: Time
  joinedAtGTE: Time
  joinedAtLT: Time
  joinedAtLTE: Time
  """
  removed_at field predicates
  """
  removedAt: Time
  removedAtNEQ: Time
  removedAtIn: [Time!]
  removedAtNotIn: [Time!]
  removedAtGT: Time
  removedAtGTE: Time
  removedAtLT: Time
  removedAtLTE: Time
  removedAtIsNil: Boolean
  removedAtNotNil: Boolean
  """
  note field predicates
  """
  note: String
  noteNEQ: String
  noteIn: [String!]
  noteNotIn: [String!]
  noteGT: String
  noteGTE: String
  noteLT: String
  noteLTE: String
  noteContains: String
  noteHasPrefix: String
  noteHasSuffix: String
  noteIsNil: Boolean
  noteNotNil: Boolean
  noteEqualFold: String
  noteContainsFold: String
  """
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
  """
  user edge predicates
  """
  hasUser: Boolean
  hasUserWith: [UserWhereInput!]
  """
  designation edge predicates
  """
  hasDesignation: Boolean
  hasDesignationWith: [DesignationWhereInput!]
}
```

## Related queries (1)

```graphql
  projectMembers(
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
    Ordering options for ProjectMembers returned from the connection.
    """
    orderBy: [ProjectMemberOrder!]
    """
    Filtering options for ProjectMembers returned from the connection.
    """
    where: ProjectMemberWhereInput
  ): ProjectMemberConnection!
```

## Related mutations (2)

```graphql
  createProjectMember(input: CreateProjectMemberInput!): ProjectMember!
  """Update a project member (e.g. set removed_at to soft-delete)"""
  updateProjectMember(id: ID!, input: UpdateProjectMemberInput!): ProjectMember!
```

---

See also: [`../API.md`](../API.md) for the flat reference · [`../SKILL.md`](../SKILL.md) for the agent operating manual · [`../playbooks/`](../playbooks/) for end-to-end workflows.
