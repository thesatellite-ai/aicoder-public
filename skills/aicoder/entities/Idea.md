# Idea

Per-entity reference for the `Idea` GraphQL type. Generated from `apidash/internal/graph/schemas/*.graphql` — regenerate via `task skill:gen`.

## Enums used by this entity

GraphQL enum literals are **bare identifiers in UPPER_SNAKE_CASE**, never quoted strings. `status: ACCEPTED` not `status: "accepted"`. See SKILL.md → "GraphQL gotchas".

| Enum | Valid values |
|---|---|
| `IdeaStatus` | `IDEA`, `ACCEPTED`, `REJECTED`, `SHIPPED`, `DUPLICATE`, `ARCHIVED` |

Lifecycle: starts as `IDEA` (default). Promote to `ACCEPTED` when committing to it (link `convertedTaskID` or `convertedPlanID` at the same time), `SHIPPED` when delivered, `REJECTED` if dropped, `DUPLICATE` if it matches an existing idea.

## Required fields on `createIdea`

**`subject` OR `areaID` is required** — the server rejects with `"createIdea: areaID or subject required"` if both are omitted. `title` is always required separately.

```graphql
mutation {
  createIdea(input: {
    projectID: "prj_…"
    title: "Idea title"
    subject: "auth"           # OR areaID, but at least one
  }) { id }
}
```

## Object type

_Defined in `ent.graphql`._

```graphql
type Idea implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: ID!
  areaID: ID
  subject: String
  title: String!
  body: String
  status: IdeaStatus!
  votes: Int!
  sourceURL: String
  convertedTaskID: ID
  convertedPlanID: ID
  createdByUserID: String
  project: Project!
  area: Area
  convertedTask: Task
  convertedPlan: Plan
}
```

## Create input

```graphql
input CreateIdeaInput {
  workspaceID: String
  subject: String
  title: String!
  body: String
  status: IdeaStatus
  votes: Int
  sourceURL: String
  createdByUserID: String
  projectID: ID!
  areaID: ID
  convertedTaskID: ID
  convertedPlanID: ID
}
```

## Update input

```graphql
input UpdateIdeaInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  subject: String
  clearSubject: Boolean
  title: String
  body: String
  clearBody: Boolean
  status: IdeaStatus
  votes: Int
  sourceURL: String
  clearSourceURL: Boolean
  createdByUserID: String
  clearCreatedByUserID: Boolean
  projectID: ID
  areaID: ID
  clearArea: Boolean
  convertedTaskID: ID
  clearConvertedTask: Boolean
  convertedPlanID: ID
  clearConvertedPlan: Boolean
}
```

## Where filter (top-level connection)

```graphql
input IdeaWhereInput {
  not: IdeaWhereInput
  and: [IdeaWhereInput!]
  or: [IdeaWhereInput!]
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
  subject field predicates
  """
  subject: String
  subjectNEQ: String
  subjectIn: [String!]
  subjectNotIn: [String!]
  subjectGT: String
  subjectGTE: String
  subjectLT: String
  subjectLTE: String
  subjectContains: String
  subjectHasPrefix: String
  subjectHasSuffix: String
  subjectIsNil: Boolean
  subjectNotNil: Boolean
  subjectEqualFold: String
  subjectContainsFold: String
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
  status field predicates
  """
  status: IdeaStatus
  statusNEQ: IdeaStatus
  statusIn: [IdeaStatus!]
  statusNotIn: [IdeaStatus!]
  """
  votes field predicates
  """
  votes: Int
  votesNEQ: Int
  votesIn: [Int!]
  votesNotIn: [Int!]
  votesGT: Int
  votesGTE: Int
  votesLT: Int
  votesLTE: Int
  """
  source_url field predicates
  """
  sourceURL: String
  sourceURLNEQ: String
  sourceURLIn: [String!]
  sourceURLNotIn: [String!]
  sourceURLGT: String
  sourceURLGTE: String
  sourceURLLT: String
  sourceURLLTE: String
  sourceURLContains: String
  sourceURLHasPrefix: String
  sourceURLHasSuffix: String
  sourceURLIsNil: Boolean
  sourceURLNotNil: Boolean
  sourceURLEqualFold: String
  sourceURLContainsFold: String
  """
  converted_task_id field predicates
  """
  convertedTaskID: ID
  convertedTaskIDNEQ: ID
  convertedTaskIDIn: [ID!]
  convertedTaskIDNotIn: [ID!]
  convertedTaskIDGT: ID
  convertedTaskIDGTE: ID
  convertedTaskIDLT: ID
  convertedTaskIDLTE: ID
  convertedTaskIDContains: ID
  convertedTaskIDHasPrefix: ID
  convertedTaskIDHasSuffix: ID
  convertedTaskIDIsNil: Boolean
  convertedTaskIDNotNil: Boolean
  convertedTaskIDEqualFold: ID
  convertedTaskIDContainsFold: ID
  """
  converted_plan_id field predicates
  """
  convertedPlanID: ID
  convertedPlanIDNEQ: ID
  convertedPlanIDIn: [ID!]
  convertedPlanIDNotIn: [ID!]
  convertedPlanIDGT: ID
  convertedPlanIDGTE: ID
  convertedPlanIDLT: ID
  convertedPlanIDLTE: ID
  convertedPlanIDContains: ID
  convertedPlanIDHasPrefix: ID
  convertedPlanIDHasSuffix: ID
  convertedPlanIDIsNil: Boolean
  convertedPlanIDNotNil: Boolean
  convertedPlanIDEqualFold: ID
  convertedPlanIDContainsFold: ID
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
  """
  area edge predicates
  """
  hasArea: Boolean
  hasAreaWith: [AreaWhereInput!]
  """
  converted_task edge predicates
  """
  hasConvertedTask: Boolean
  hasConvertedTaskWith: [TaskWhereInput!]
  """
  converted_plan edge predicates
  """
  hasConvertedPlan: Boolean
  hasConvertedPlanWith: [PlanWhereInput!]
}
```

## Related queries (1)

```graphql
  ideas(
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
    Ordering options for Ideas returned from the connection.
    """
    orderBy: [IdeaOrder!]
    """
    Filtering options for Ideas returned from the connection.
    """
    where: IdeaWhereInput
  ): IdeaConnection!
```

## Related mutations (6)

```graphql
  createIdea(input: CreateIdeaInput!): Idea!
  promoteIdeaToPlan(ideaID: ID!, specID: ID, createdByUserID: ID): Idea!
  promoteIdeaToTask(ideaID: ID!, ownerListID: ID, createdByUserID: ID): Idea!
  rejectIdea(ideaID: ID!, reason: String): Idea!
  updateIdea(id: ID!, input: UpdateIdeaInput!): Idea!
  voteIdea(id: ID!): Idea!
```

---

See also: [`../API.md`](../API.md) for the flat reference · [`../SKILL.md`](../SKILL.md) for the agent operating manual · [`../playbooks/`](../playbooks/) for end-to-end workflows.
