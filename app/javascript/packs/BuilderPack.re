let decodeProps = json =>
  Json.Decode.(
    json |> field("prescriptions", array(Prescription__Prescription.decode)),
  );

let prescriptions = DomUtils.parseJSONTag() |> decodeProps;

ReactDOMRe.renderToElementWithId(
  <PrescriptionBuilder
    prescriptions
  />,
  "react-root",
);