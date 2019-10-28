import React from "react"
import PropTypes from "prop-types"

class VoteButton extends React.Component {
  render () {
    return (
      <React.Fragment>
        <button
          className={this.props.className}
          onClick={this.props.callback}
        >
          {this.props.value}
        </button>
      </React.Fragment>
    );
  }
}

VoteButton.propTypes = {
  className: PropTypes.string,
  callback: PropTypes.func,
  value: PropTypes.string,
};

export default VoteButton
